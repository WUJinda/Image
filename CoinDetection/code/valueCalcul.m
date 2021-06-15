%% Projet Image 
%% WU Jinda
clear all;clc;
close all;

%%

%Convertir les images RVB en valeurs de niveaux de gris
Img =rgb2gray(imread('test20.jpg'));
%Compresser la taille de l'image
Img = imresize(Img,[800 NaN]);
figure(),subplot(3,3,1),imshow(Img);title('image gray');
%Appliquez une transformation morphologique pour supprimer du Fond.
s=strel('disk',50);
test_tophat=imclose(Img,s)-Img;
img_gray=255-test_tophat;
subplot(3,3,2),imshow(img_gray,[]);title('image gray after tophat');
%Utilisez l'opérateur Sobel pour la détection des bords.
img_edge =edge(img_gray,'sobel');
subplot(3,3,3), imshow(img_edge ,[]), title('edge detection sobel');

se=strel('disk',8);
img_close = imclose(img_edge, se);

subplot(3,3,4),imshow(img_close,[]);title('image close');
%Remplir les trous
img_fill = imfill(img_close, 'holes');
Img_clean = bwareaopen(img_fill, 500);   
subplot(3,3,5),imshow(Img_clean,[]);title('image gray clean');


figure();imshow(Img);title('image gray');hold on
%Déterminez le centre, le diamètre et la surface de la pièce.
[B, L] = bwboundaries(Img_clean);
stats = regionprops(L,Img(:,:,1),...
    'Area','Centroid','Orientation','EquivDiameter','MeanIntensity');

coinCentroids = [];
coinArea = [];
coinEquivDiameter=[];

for k = 1:length(B)
    boundary = B{k};
    delta_sq = diff(boundary).^2;
    perimeter = sum(sqrt(sum(delta_sq,2)));
    area = stats(k).Area;
    metric = 4*pi*area/perimeter^2;
    metric_string = sprintf('%2.2f',metric);
    angle_string = sprintf('%2.2f',stats(k).Orientation);
    centroid = stats(k).Centroid;

        coinCentroids = [coinCentroids; centroid];
        coinArea=[coinArea; area];
        coinEquivDiameter=[coinEquivDiameter; stats(k).EquivDiameter];

    plot(centroid(1),centroid(2),'r+');

end

E2 = 0;
E1 = 0;
C50 = 0;
C20 = 0;
C10 = 0;
C5 = 0;
C2 = 0;
C1 = 0;

%Comptez le nombre de pièces différentes
for k = 1:length(coinArea)
    if((stats(k).Area)>45000&&(stats(k).Area)<48000)
        E2=E2+1;
    elseif((stats(k).Area)>40000&&(stats(k).Area)<43000)
        C50=C50+1;
    elseif((stats(k).Area)>37000&&(stats(k).Area)<40000)
        E1=E1+1;
    elseif((stats(k).Area)>32800&&(stats(k).Area)<36000)
        C20=C20+1;
    elseif((stats(k).Area)>30000&&(stats(k).Area)<32800)
        C5=C5+1;
    elseif((stats(k).Area)>26500&&(stats(k).Area)<29000)
        C10=C10+1;
    elseif((stats(k).Area)>24000&&(stats(k).Area)<26500)
        C2=C2+1;
    elseif((stats(k).Area)>18200&&(stats(k).Area)<20600)
        C1=C1+1;
    
    end

end
%Calculez la valeur des pièces
sum=E2*2+E1+C50*0.5+C20*0.2+C10*0.1+C5*0.05+C2*0.02+C1*0.01



% %% 
% F1 = imread('1centF.jpg');
% %F1 = imread('10centF.jpg');
% Ctest1 = imresize(F1,[800 NaN]);
% 
% figure(),imshow(Ctest1,[]);title('image RGB');
% area = size(Ctest1,1)*size(Ctest1,2);
% R = Ctest1(:,:,1);
% G = Ctest1(:,:,2);
% B = Ctest1(:,:,3);
% R_value = sum(sum(R))/area;
% G_value = sum(sum(G))/area;
% B_value = sum(sum(B))/area;
% 
% RG = R_value/G_value;
% RB = R_value/B_value;
% BG = B_value/G_value;







