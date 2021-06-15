%% TD1 - Traitement d'image
% Le but de cette séance est d'étudier les notions vues dans les chapitres
% 1, 2, 3 et 4 du cours : prétraitement, segmentation et mesures sur des
% objets.

%% 3.1. Segmentation d'une image

%%
% *Image Cailloux*
clear all;
close all;

base='Images/prova6_226';
i=1;
nom=sprintf('%s_%03d.tif',base,i-1);
f=imread(nom);
figure(1),imshow(f);

%%
% *Correction dérive de fond*
s=strel('disk',30);
f1=imclose(f,s)-f;
figure(2),imshow(f1);

%%
% *Binarisation*
fbin=tse_imthreshold(f1,1,'entropy');
figure(3),imshow(fbin);

%%
% *Séparation objets*
fbin2=tse_imsplitobjects(fbin);
figure(4),imshow(fbin2);

%%
% *Ouverture + suppression bords*
s=strel('disk',1);
fbin3=imopen(fbin2,s);
fbin3=imclearborder(fbin3);
figure(5),imshow(fbin3);

%% 3.2. Distribution granulométrique
%
% *Labelisation*
[fe,n]=bwlabel(fbin3);
fe_rgb=label2rgb(fe);
figure(6),imshow(fe_rgb);

%%
% *Mesures*
mes=regionprops(fe,'EquivDiameter');
d=[mes.EquivDiameter];
% Conversion
d=d/size(f,1)*150;
% Histogramme
figure(7);
h=hist(d,1:ceil(max(d)));
bar(2:12,h(2:12));

%% 3.3 Traitement de la séquence

base='Images/prova6_226';
h=zeros(11,15);
for i=1:15
   nom=sprintf('%s_%03d.tif',base,i-1);
   disp(nom);
    f=imread(nom);
    h(:,i)=distribution_taille(f,150,2:12);
end
h_cumule=sum(h,2);
figure(8);
bar(2:12,h_cumule);
