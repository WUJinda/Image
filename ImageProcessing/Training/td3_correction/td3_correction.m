%% TD3 - Traitement d'image - Détection de contours
%
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

[gmax1,gh,gv]=tse_imgrad(f,'sobel');
g1=sqrt(gh.^2+gv.^2);
figure(2);
subplot(1,2,1),imshow(g1,[]);
subplot(1,2,2),imshow(gmax1,[]);
colormap(jet)

figure(3);
subplot(1,2,1),imshow(gh,[]);
subplot(1,2,2),imshow(gv,[]);

%%
% *2.2.2 Gradients de gaussienne*

[gmax2,gh,gv]=tse_imgrad(f,'gog',1);
g2=sqrt(gh.^2+gv.^2);
figure(4);
subplot(1,2,1),imshow(g2,[]);
title('sigma=1');
subplot(1,2,2),imshow(gmax2,[]);
colormap(jet)

[gmax3,gh,gv]=tse_imgrad(f,'gog',2);
g3=sqrt(gh.^2+gv.^2);
figure(5);
subplot(1,2,1),imshow(g3,[]);
title('sigma=2');
subplot(1,2,2),imshow(gmax3,[]);
colormap(jet)

[gmax4,gh,gv]=tse_imgrad(f,'gog',4);
g4=sqrt(gh.^2+gv.^2);
figure(6);
subplot(1,2,1),imshow(g4,[]);
title('sigma=4');
subplot(1,2,2),imshow(gmax4,[]);
colormap(jet)


%% 2.4 Seuillage hystérésis

gmax=gmax1;
fs=tse_imhysthreshold(gmax,20);
fs=imfill(fs,'holes');
figure(7);
subplot(1,2,1),imshow(f);
subplot(1,2,2),imshow(fs,[]),title('seuil haut = 20');

[fs,h]=tse_imhysthreshold(gmax2);
fs=imfill(fs,'holes');


figure(8);
subplot(1,2,1),imshow(f);
subplot(1,2,2),imshow(fs,[]),title(sprintf('seuil haut = %.2g',h));

[fs,h]=tse_imhysthreshold(gmax4);
fs=imfill(fs,'holes');
figure(9);
subplot(1,2,1),imshow(f);
subplot(1,2,2),imshow(fs,[]),title(sprintf('seuil haut = %.2g',h));

%%
% *Post traitement*

[fs,h]=tse_imhysthreshold(gmax);
figure(7);
fss=imfill(fs,'holes');
subplot(1,2,1),imshow(f);
subplot(1,2,2),imshow(fss,[]);

%% 2.5 Fermeture des contours

clear all;
close all;

f=imread('Images/Cailloux.bmp');
figure(1);
imshow(f);

[gmax,gh,gv]=tse_imgrad(f,'gog',1);
fs=tse_imhysthreshold(gmax);
fs2=tse_imextendedge(fs,gh,gv);

figure(2)
imshow(fs)
figure(3)
imshow(fs2)

figure(4)
fs=bwmorph(fs,'spur');
fs=imfill(fs,'holes');
imshow(fs)
figure(5)
fs2=bwmorph(fs2,'spur');
fs2=imfill(fs2,'holes');
imshow(fs2)


%% 2.6 Image floue et bruitée

clear all;
close all;

f=imread('Images/Jet_Diesel.bmp');
figure(1);
imshow(f);

[gmax,gh,gv]=tse_imgrad(f,'gog',3);
fs=tse_imhysthreshold(gmax);
fs2=tse_imextendedge(fs,gh,gv,4);

figure(2);
imshow(fs);
figure(3);
imshow(fs2);


%% 2.7 Segmentation par ligne de partage des eaux (LPE)

% Module du gradient
[gm,gh,gv]=tse_imgrad(f,'gog',2);
g=sqrt(gh.*gh+gv.*gv);
figure(4),imshow(g,[],'ColorMap',jet);

% Simplification du gradient*
g1=imhmin(g,6);
figure(5),imshow(g1,[],'ColorMap',jet);

% LPE du gradient 
lpe=watershed(g1);
figure(6),imshow(lpe==0,[]);

%% 2.8 LPE avec sélection des bassins
% *Détermination des marqueurs internes*

ff=imfilter(f,fspecial('gaussian',[49 49],12),'replicate');
figure(7),imshow(ff,[]);
fmi=imextendedmax(ff,5);
figure(8),imshow(fmi);

%%
% *Marqueurs externes et segmentation*

fmo=watershed(imimposemin(255-f,fmi));
figure(9),imshow(fmo==0);
fm=fmi | (fmo==0);
figure(10),imshow(fm);
fs=watershed(imimposemin(g,fm));
figure(11),imshow(fs==0);

