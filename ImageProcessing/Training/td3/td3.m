%% TD3 - Traitement d'image - Détection de contours
%
%% WU Jinda

% Le but de cette séance est d'étudier les principaux opérateurs de
% détection de contours

%% 2.2 Comparaison des différents gradients

clear all;
close all;

f=imread('Images/ZoneCailloux.bmp');
figure(1);
imshow(f);

%%
% *2.2.1 Gradient de sobel*
[fs,fsh,fsv]=tse_imgrad(f,'sobel');
figure(2)
imshow(fs , []);


%%
% *2.2.2 Gradients de gaussienne*
[fg1,fg1h,fg1v]=tse_imgrad(f,'gog', 1);
[fg2,fg2h,fg2v]=tse_imgrad(f,'gog', 2);
[fg8,fg8h,fg8v]=tse_imgrad(f,'gog', 8);

figure(3)
subplot(1,3,1);imshow(fg1, []);title("gog,sigma=1");
subplot(1,3,2);imshow(fg2, []);title("gog,sigma=2");
subplot(1,3,3);imshow(fg8, []);title("gog,sigma=8");


figure(4)
subplot(1,3,1);imshow(fs,[]);title("sobel");
subplot(1,3,2);imshow(fsh,[]);title("sobel, horizontale");
subplot(1,3,3);imshow(fsv,[]);title("sobel, verticale");



figure(5)
subplot(1,3,1);imshow(fg1,[]);title("gog");
subplot(1,3,2);imshow(fg1h,[]);title("gog, horizontale,sigma=1");
subplot(1,3,3);imshow(fg1v,[]);title("gog, verticale,sigma=1");
%Dans les images des maximas locaux,la valeur de chaque pixel est le
%gradient.Le partie blanc a le gradient plus fort et cette partie est
%exactement le contour de l'objet.


figure(6)
subplot(2,2,1);imshow(fg1h,[]);title("gog, horizontale,sigma=1");
subplot(2,2,2);imshow(fg2h,[]);title("gog, horizontale,sigma=2");
subplot(2,2,3);imshow(fg1v,[]);title("gog, verticale,sigma=1");
subplot(2,2,4);imshow(fg2v,[]);title("gog, verticale,sigma=2");

%% 2.3
% les paramétres d'entrée :f(image),high(la valeur d'un seuil 
% haut),low(la valeur d'un seuil bas);les paramétres de sortie:fs(l'image
% de reconstruction),high(la valeur d'un seuil haut)

% la fonction find_threshold permet de donner  une valeur de haut quand la
% paramétre est f 
%% 2.4 Seuillage hystérésis

fseu=tse_imhysthreshold(fs1,16);
figure(7);
imshow(fseu,[]);
title('image traite par sobel aprés de seuillage');

fseu=tse_imhysthreshold(fg1,6);
figure(8);
imshow(fseu,[]);
title('image traitée par gausien aprés de seuillage plus petite');

fseu_normal=tse_imhysthreshold(fg1,16);
figure(9);
imshow(fseu_normal,[]);
title('image traitée par gausien aprés de seuillage');

fseu=tse_imhysthreshold(fg1,26);
figure(10);
imshow(fseu,[]);
title('image traitée par gausien aprés de seuillage plus grande');

[fseuA,high]=tse_imhysthreshold(fg1);
low=high*0.4;
figure(11);
imshow(fseuA,[]);
title('image traitée par gausien aprés de seuillage sans valeur de seuil');

fill=imfill(fseu_normal,'holes');
figure(12);
imshow(fill,[]);
title('image traité par imfill')

f2 = f;
f2(fseu_normal) = 255;
figure(13)
imshow(f2,[]);title("image avec contour")



%%
% *Post traitement*

fext=tse_imextendedge(fseuA,fg1h,fg1v,4);
figure(14)
imshow(fext, []);

fext=tse_imextendedge(fseu_normal,fg1h,fg1v,4);
figure(15)
imshow(fext, []);

%% 2.5 Fermeture des contours

clear all;
close all;

f=imread('Images/Cailloux.bmp');
figure(1);
imshow(f,[]);
title('image originale');
[fs,gh,gv]=tse_imgrad(f,'gog',1);
figure(2);
imshow(fs,[]);
title('image traitée par fonction tse_imgrad');
fsth=tse_imhysthreshold(fs);
figure(3);
imshow(fsth,[]);
title('image ayant défaut')
%Il existe le contour qui ne se touche pas.
fext=tse_imextendedge(fsth,gh,gv);
figure(4);
imshow(fext);
title('image corrigée');

fext=imfill(fext,'holes');
fext = bwmorph(fext,'spur');
fsth=imfill(fsth,'holes');
fsth = bwmorph(fsth,'spur');
d=strel('disk',2);
fext=imopen(fext,d);
fext=imclearborder(fext);
fsth=imclearborder(fsth);
figure(5);
subplot(1,2,1);imshow(fext);title('imfill-bwmorph-imextendedge');
subplot(1,2,2);imshow(fsth);title('imfill-bwmorph-imhysthreshold');



%% 2.6 Image floue et bruitée

clear all;
close all;

f=imread('Images/Jet_Diesel.bmp');
figure(1);
imshow(f);

[fmax, fh, fv] = tse_imgrad(f, 'gog',2.5);
figure(2);imshow(fmax,[]);title("imgrad gog sigma=3");
fdth=tse_imhysthreshold(fmax);
figure(3);imshow(fdth,[]);title("tse_imhysthreshold");
fdex=tse_imextendedge(fdth,fh,fv,8);
figure(4);imshow(fdex,[]);title("tse_imextendedge");

fss = bwmorph(fdex,'spur', Inf);
figure(5);imshow(fss,[]);title("bwmorph spur inf");

fseg = imfill(fss,'holes');
figure(6);imshow(fseg,[]);title("imfill");


%% 2.7 Segmentation par ligne de partage des eaux (LPE)
f=imread('Images/Jet_Diesel.bmp');
figure(1);
imshow(f);
% Module du gradient
[gmax, gh, gv] = tse_imgrad(f, 'gog',2);
g = sqrt(gh.^2+gv.^2);
figure(2);imshow(g,[]);title("Module du gradient");

% Simplification du gradient*
g2 = imhmin(g, 6);
g2_test = imhmin(g, 7);
figure(4);imshow(g2,[]);title("Simplification du gradient* ");

% LPE du gradient 
ws = watershed(g)==0;
figure(3);imshow(ws,[]);title("LPE du gradient par g");


ws = watershed(g2)==0;
figure(5);imshow(ws,[]);title("LPE du gradient par g2");


ws = watershed(g2_test)==0;
figure(6);imshow(ws,[]);title("LPE du gradient par g2 for test");

%% 2.8 LPE avec sélection des bassins
% *Détermination des marqueurs internes*
f=imread('Images/Jet_Diesel.bmp');
figure(1);imshow(f);title("Ïmage original");

f1 = imgaussfilt(f, 8);
figure(7);imshow(f1, []);title("lissage gaussien");
m_int = imextendedmax(f1, 18); %The reason why this value is set larger is to get as centered as possible as a "marker". If the setting is too small in order to get a smaller "mark", it will deviate. This is why it works with the following function.
m_int = bwmorph(m_int, 'thin', 5);
figure(8);imshow(m_int, []);title("imextendedmax");



%%
% *Marqueurs externes et segmentation*

f2 = imimposemin(255-f, m_int);
m_ext = watershed(f2) == 0;
figure(9);imshow(m_ext, []);title("*Marqueurs externes et segmentation*")

m = m_int | m_ext;
figure(10);imshow(m,[]);title("m_int or m_ext");

g2 = imimposemin(g, m);
fseg2 = watershed(g2)==0;
figure(11);imshow(fseg2,[]);title("f_seg avec g2");

