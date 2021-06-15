%% Projet Image 
%% WU Jinda
clear all;clc;
close all;

%% For Data

Img1 =rgb2gray(imread('1.jpg'));

Img1 = imresize(Img1,[800 NaN]);
figure(),subplot(2,2,1),imshow(Img1);title('image gray');
s=strel('disk',50);
test_tophat=imclose(Img1,s)-Img1;
subplot(2,2,2),imshow(test_tophat,[]);title('image gray after tophat');
img_gray=255-test_tophat;
subplot(2,2,1),imshow(img_gray,[]);title('image gray');

img_edge =edge(img_gray,'sobel');
subplot(2,2,2), imshow(img_edge ,[]), title('edge detection sobel');

se=strel('disk',8);
img_close = imclose(img_edge, se);

subplot(2,2,3),imshow(img_close,[]);title('image close');

img_fill = imfill(img_close, 'holes');
Img_clean = bwareaopen(img_fill, 500);   
subplot(2,2,4),imshow(Img_clean,[]);title('image gray filled');

figure();imshow(Img1);title('image gray');hold on

[B, L] = bwboundaries(Img_clean);
stats = regionprops(L,Img1(:,:,1),...
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









