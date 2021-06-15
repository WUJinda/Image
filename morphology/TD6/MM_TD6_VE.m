%% Mathematical Morphology - Watershed segmentation
% Assignment 6

% Nom : 
% Prénom : 

% In this assignment, you will learn about the watershed transformation and
% its applications : separation of overlapping blobs and segmentation.
% You will use the Matlab function 'watershed' which can find the catchment 
% basins and watershed lines for any grayscale image. 


%% PART 1 - Distance transform and Watershed 

% Combined with a distance transform, the watershed transformation can help
% separating touching objects. In this part, you will study the 2D 
% example provided by Matlab. This example presents the task of separating two 
% touching objects in a binary image. Second, you will apply the method to 
% separate the touching circles in a binary image. 

% Links :
% http://www.mathworks.fr/company/newsletters/articles/the-watershed-transform-strategies-for-image-segmentation.html
% http://cmm.ensmp.fr/~beucher/wtshed.html
% Matlab 2D example (watershed function)


% 1.1. Segmentation of connected circles
% The studied image is a binary image of connected circles. 

% 1.2.1. Open the image circles.png.
clear all;
close all;

IBW=imread('circles.png');
figure(1), imshow(IBW)

% 1.2.2. Segment (and disconnect) the circles using a distance transform
D =  bwdist(~IBW);
figure(2), imshow(D, [ ]);title('image using a distance transform');

D_complement = -D;
figure(3), imshow(D_complement, [ ]);title('image complement of D');

D_min = imhmin(D_complement, 2);
figure(4), imshow(D_min, [ ]);title('after imhmin');
L = watershed(D_min);
figure(5), imshow(L,[ ]), title("watershed after imhmin");


rgb = label2rgb(L);
figure(6), imshow(rgb), title('Watershed avec les bassins versants');

IBW_new = IBW;
IBW_new(L==0) = 0;
figure(7), imshow(IBW_new), title("show lines");
% 1.2.3. In this approach, what is the main parameter ? Modify it to
% observe its influence.


D = bwdist(~IBW,'cityblock');
figure(14), imshow(D, [ ]);title('cityblock');
D = -D;
D=imhmin(D,2);
L = watershed(D);
IBWW=IBW;
IBWW(L==0)=0;
figure(8), imshow(IBWW)
title('Watershed transform with cityblock distance')

D = bwdist(~IBW,'chessboard');
D = -D;
D=imhmin(D,2);
L = watershed(D);
IBWW=IBW;
IBWW(L==0)=0;
figure(9), imshow(IBWW)
title('Watershed transform with chessboard distance')

D = bwdist(~IBW,'quasi-euclidean');
D = -D;
D=imhmin(D,2);
L = watershed(D);
IBWW=IBW;
IBWW(L==0)=0;
figure(10), imshow(IBWW)
title('Watershed transform with quasi-euclidean distance')


% Answer : 


% Observations :

% 
%% PART 2 - Minima imposition
% You can emphasize specific minima (dark objects) in an image using the imimposemin function.
% The imimposemin function uses morphological reconstruction to eliminate all minima 
% from the image except the minima you specify.
% 
% To illustrate the process of imposing a minimum, this code creates a simple image 
% containing two primary regional minima and several other regional minima.
clear all;
close all;



mask = uint8(10*ones(10,10));
mask(6:8,6:8) = 2;
mask(2:4,2:4) = 7;
mask(3,3) = 3;
mask(2,9) = 9;
mask(3,8) = 9;
mask(9,2) = 9;
mask(8,3) = 9


figure(1),imagesc(mask),colormap('gray');
% 2.1. Creating a Marker Image

% To obtain an image that emphasizes the two deepest minima and removes all others, 
% create a marker image that pinpoints the two minima of interest. You can create 
% the marker image by explicitly setting certain pixels to specific values or by 
% using other morphological functions to extract the features you want to emphasize
% in the mask image (ultimate erosion, minr, maxr, ..).

% -> Propose a method to extract the two deepest minima

marker = imextendedmin(mask,2)
figure(2),imagesc(marker),colormap('gray');


% 2.1.2. Applying the Marker Image to the Mask

% a) Now use imimposemin to create new minima in the mask image at the points 
% specified by the marker image. Note how imimposemin sets the values of 
% pixels specified by the marker image to the lowest value supported by the 
% datatype (0 for uint8 values). 

I = imimposemin(mask, marker);
figure(2),imagesc(I),colormap('gray');


% b) Comment the result


% Remark : you can modify the test image values to understand the method. 

%% PART 3 - Marker-controlled Watershed 


 % If the imaging conditions are not optimal or the image is cluttered, 
 % thresholding does not produce acceptable segmentation. 

 %% 3.1.Segmentation of vertical stripes 
 
 %3.1.1. Open the image 'fabricTexture.jpg' and threshold it.
 clear all
 close all
I=imread('fabricTexture.jpg');
I=rgb2gray(I);
figure(1), imshow(I), title('Image originale')
I2=I;
level = graythresh(I);
IBW = im2bw(I,level);
figure(2), imshow(IBW), title('image seuillée')



%  Comment the result :



% 3.1.2. Apply a marker-controlled Watershed segmentation to detect
% white vertical stripes.The goal is to obtain a result image similar to the
% given fabricTextureSeg.jpg

  Ires=imread('fabricTextureSeg.jpg');
  figure(3),imagesc(Ires), colormap(gray)


% Hint : read the Matlab demo : Image Processing-> Image
% Segmentation -> Marker-controlled watershed segmentation.

  % 3.1.2.1. Definition of internal markers
se = strel('rectangle', [40, 10]);
I_dil = imdilate(I2, se);
figure(4),imshow(I_dil),title('Dilatation par un rectangle vertical');

  % 3.1.2.2. Definition of external markers
  
  % 3.1.2.3. Watersehd segmentation
  
%% 3.2. Segmentation of the beef image

 %3.2.1. Open the image 'boeuf.jpg'.
 clear all
 close all
I=imread('boeuf.jpg');
I2=I;
level = graythresh(I);
IBW = im2bw(I,level);
figure, imshow(IBW), title('image seuillée')


% 3.2.2. Apply a marker-controlled Watershed segmentation to detect
% white vertical stripes.The goal is to obtain a result image similar to the
% given fabricTextureSeg.jpg

  Ires=imread('boeufSeg.jpg');
  figure,imagesc(Ires), colormap(gray)



  % 3.2.2.1. Definition of internal markers

  
  % 3.2.2.2. Definition of external markers

  
  % 3.2.2.3. Watersehd segmentation














