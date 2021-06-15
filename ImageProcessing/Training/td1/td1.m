clear all;
close all;

%% Selection d'une image pour mettre au point les traitements

% Definition du format pour le nom de fichier
format_nom='Images/prova6_226_%03d.tif';
% Selection d'un numero d'image a lire
i=1;
% Lecture et affichage
f=imread(sprintf(format_nom,i-1));
figure(1);
imshow(f);


%% Segmentation de l'image de test

%% 1. Correction de la derive de fond

se = strel('disk', 30);
f_c = imclose(f, se);
figure
imshow(f_c);

%bottom hat
f_bh = f_c-f;
figure
imshow(f_bh);


%% 2. Segmentation automatique

figure
imhist(f_bh);
level = graythresh(f_bh);
f_bw = im2bw(f_bh,level);
subplot(2,1,1);
imshow(f_bw);
BW = imbinarize(f_bh, 'global');
subplot(2,1,2);
imshow(BW);

% avec fonction "tse_imthreshold"

 [seg_I,level_v] = tse_imthreshold(f_bh, 1, 'variance');
subplot(1, 2, 1)
imshow(seg_I);

 [seg_I,level_e] = tse_imthreshold(f_bh, 1, 'entropy');
 
 subplot(1, 2, 2)
imshow(seg_I);


%% 3. Post-traitements pour supprimer les defauts residuels



% f_clear = imclearborder(seg_I,);
% figure
% imshow(f_clear);

se_post = strel('disk', 3);
f_final = imopen(seg_I, se_post);
figure
imshow(f_final);

f_separation = tse_imsplitobjects(f_final);
figure
imshow(f_separation);


%% Distribution granulometrique

%% 1. Mesure du diametre de tous les objets

[fe,n]=bwlabel(f_separation);
diam=regionprops(fe,'EquivDiameter');
a=[diam.EquivDiameter];
idx=find(a>=6.4&a<=38.4);
fe2=ismember(fe,idx);
figure
imshow(fe2);

%% 2. Conversion en milimetres
[fe,n1]=bwlabel(fe2);
diam2=regionprops(fe2,'EquivDiameter');
a2=[diam2.EquivDiameter];
a2=a2*(5/16);
%% 3. Calcul de la distribution

figure
hist(a2);
%% Traitement de la sequence
% Definir la fonction distribution_taille dans le fichier distribution_taille.m

h_cumule=zeros(1,20);
for i=1:15
  nom=sprintf(format_nom,i-1);
  disp(sprintf('Traitement de l''image %s...',nom));
  f=imread(nom);
  h=distribution_taille(f,150,1:20);
  h_cumule=h_cumule+h;
end

figure(2);
bar(1:20,h_cumule);

