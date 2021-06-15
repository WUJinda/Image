%% Mathematical Morphology - Grayscale morphological reconstruction
% Assignment 5

% Nom : WU
% Prénom : Jinda

% Grayscale images can be thought of in three dimensions: 
% the x- and y-axes represent pixel positions and the z-axis
% represents the intensity of each pixel. In this interpretation, 
% the intensity values represent elevations, as in a topographical map.
% The areas of high intensity and low intensity in an image, peaks and 
% valleys in topographical terms, can be important morphological features
% because they often mark relevant image objects.


%% 1. Finding peaks and valleys

clear all;
close all;

% The following simple image contains two primary regional maxima,
% the blocks of pixels containing the value 13 and 18, and several smaller maxima,
% set to 11.

A= [10 10 10 10 10 10 10 10 10 10
    10 13 13 13 10 10 11 10 11 10
    10 13 13 13 10 10 10 11 10 10
    10 13 13 13 10 10 11 10 11 10
    10 10 10 10 10 10 10 10 10 10
    10 11 10 10 10 18 18 18 10 10
    10 10 10 11 10 18 18 18 10 10
    10 10 11 10 10 18 18 18 10 10
    10 11 10 11 10 10 10 10 10 10
    10 10 10 11 10 10 11 10 10 10] ;
figure(1)
imagesc(A), colormap(gray);

%%%
% *1.1. Extract all regional maxima using imregionalmax*
BW = imregionalmax(A);
figure(2);
imagesc(BW), colomap(gray);

% Code


%%% 
% Comment:
%
% What is the type of the result image ?
%
% Answer: On obtient une image binaire avec plusieurs max régionaux, mais
%on n'a plus d'information sur l'impitude des max régionaux

%%%
% *1.2. Extended regional maxima*
%
% You might want only to identify areas of the image where 
% the change in intensity is extreme; that is, the difference 
% between the pixel and neighboring pixels is greater than 
% (or less than) a certain threshold. For example, to find only 
% those regional maxima in the sample image, A, that are at least two units
% higher  than their neighbors, use imextendedmax. 

%%%
% *1.2.a) What is the difference between the two functions imregionalmax
% and imextendedmax?*
%
% Answer: parameter h of contrast

%%%
% *1.2.b)*

%Code:
figure(3)
MaxEtendus = imextendedmax(A,2);
imagesc(MaxEtendus), colormap(gray)


%%%
% *1.2.c)*
%
% Comment (+ comparison with the previous result)
%
% Answer : on n'a plus que 2 maxima, les autres ont étéfiltré en fonction
% de contraste.

% h means the diff (or call it threshold) between each pixel and the min
% pixel not less than the setted value. 

%% 2. Suppressing Minima and Maxima
% In an image, every small fluctuation in intensity represents a regional 
% minimum or maximum. You might only be interested in significant minima 
% or maxima and not in these smaller minima and maxima caused by background texture.
% 
% To remove the less significant minima and maxima but retain the significant minima 
% and maxima, use the imhmax or imhmin function. With these functions, you can specify 
% a contrast criteria or threshold level, h, that suppresses all maxima whose height is 
% less than h or whose minima are greater than h.

%%%
% *2.1. hmin and hmax*
%
% Which type of image is returned with imhmin or imhmax? (BW, grey, color,
% .. ) ?
%
% Important note : The imregionalmin, imregionalmax, imextendedmin, and
% imextendedmax functions return a binary image that marks the locations of the regional 
% minima and maxima in an image. The imhmax and imhmin functions produce an altered image.
%
%
%
% The simple image B contains two primary regional maxima, the blocks of pixels containing 
% the value 14 and 18, and several smaller maxima, set to 11.


B= [10 10 10 10 10 10 10 10 10 10
    10 14 14 14 10 10 11 10 11 10
    10 14 14 14 10 10 10 11 10 10
    10 14 14 14 10 10 11 10 11 10
    10 10 10 10 10 10 10 10 10 10
    10 11 10 10 10 18 18 18 10 10
    10 10 10 11 10 18 18 18 10 10
    10 10 11 10 10 18 18 18 10 10
    10 11 10 11 10 10 10 10 10 10
    10 10 10 11 10 10 11 10 10 10] ;

%%%
% *2.2.*
%
% By using imhmax, eliminate all regional maxima except the two significant maxima
% (with values 14 and 18). Compare the values of the resulting matrix with 
% the original matrix B. 

%%%
% *2.2.a)*

% Code:

figure(4)
imagesc(B), colormap(gray)
B1=imhmax(B,2)
figure(5)
imagesc(B1), colormap(gray);

B2= B - B1
figure(6);
imagesc(B2), colormap(gray);



%%%
% *2.2.b)*
%
% Comment :
%
%



%%%
% *2.3*
%
% The simple image C contains two primary regional maxima, the blocks of pixels containing 
% the values 14 and 18, and several smaller maxima, set to 11. One pixel of the regional
% maximum of value 14 is corrupted by noise and set to 1.  


C= [10 10 10 10 10 10 10 10 10 10
    10 14 14 14 10 10 11 10 11 10
    10 20 14 14 10 10 10 11 10 10
    10 14 14 14 10 10 11 10 11 10
    10 10 10 10 10 10 10 10 10 10
    10 11 10 10 10 18 18 18 10 10
    10 10 10 11 10 18 18 18 10 10
    10 10 11 10 10 18 18 18 10 10
    10 11 10 11 10 10 10 10 10 10
    10 10 10 11 10 10 11 10 10 10] ;

%%%
% Eliminate all regional maxima except the two significant maxima
% (with values 14 and 18), removing the noise. Compare the values of the result matrix with 
% the original matrix C. 

%%%
% *2.3.a)*

% Code:
figure(7)
imagesc(C), colormap(gray);
C_rm = imhmax(C, 6);
figure(8)
imagesc(C_rm), colormap(gray);

%C_final = C-C_rm;
C_final = imregionalmax(C_rm);
figure(9)
imagesc(C_final), colormap(gray);

%%%
% *2.3.b)*
%
% Comment:
%
% Il faut choisir la valeur 6 car cela permet de corriger le pic de bruit,
% de ramener la valeur du pixel 20 à 14, sans supprimer l'autre maximum
% régional. Par contre, celui-ci est atténué. 


%%
% *2.4*
%
% The simple image D contains two primary regional minima, the blocks of pixels containing 
% the value 14 and 18, and several deeper minima, set to 11.


D= [24 24 24 24 24 24 24 24 24 24
    24 14 14 14 24 24 11 24 11 24
    24 14 14 14 24 24 24 11 24 24
    24 14 14 14 24 24 11 24 11 24
    24 24 24 24 24 24 24 24 24 24
    24 11 24 24 24 18 18 18 24 24
    24 24 24 11 24 18 18 18 24 24
    24 24 11 24 24 18 18 18 24 24
    24 11 24 11 24 24 24 24 24 24
    24 24 24 11 24 24 11 24 24 24] ;

%%%
% Eliminate all regional minima except the minima equal to 11, 

%%%
% *2.4.a)*

% Code:

figure(10)
imagesc(D), colormap(gray)

D2=imhmin(D,10) ; % avec 6, on supprime le min Ã  18, avec 10, on supprime le min de 14
figure(11)
imagesc(D2), colormap(gray)


%%%
% *2.4.b)*
%
% Comment:
%
%




%% 3. Application 1
%
% In this section, the goal is to segment the black objects in the image
% 'lille-stor.jpg' before applying a granulometry study.
% You can check that a simple threshold gives a good result. However, we'll
% use regional extrema operators in order to well understand these
% operators. 

clear all;
close all;
I=imread('lille-stor.jpg');

I=rgb2gray(I);
figure, imagesc(I),colormap(gray), title('I'), axis equal

%%%
% *3.1. Analysis of the input image*
%
% *3.1.1. Extract all regional minima using imregionalmin*

% Code : 

Iminr = imregionalmin(I);
figure(1)
imshow(Iminr);

%%%
% Comment :  


%%%
% *3.1.2. Extract all regional maxima using imregionalmax.*

% Code : 

Imaxr = imregionalmax(I);
figure(2)
imshow(Imaxr);

%%%
% Comment :  many regional maxima
%
% To understand the previous results, let's plot a profile.

figure(2), imagesc(I),colormap(gray), title('I'), axis equal
%improfile() 
% ou
x = [2 210];
 y = [83 83];
 improfile(I,x,y);

%%%
% What do you observe ?
%

%%%
% *3.1.2. Image segmentation*
%
% Propose a sequence of processing steps to obtain a binary image
% with the round objects. (you can plot the same profile to understand
% the result of your operations)

% Code:
figure(3) ;imagesc(I), colormap(gray); title('I'), axis equal
I_top = imhmax(I, 120);
figure(4);  improfile(I_top,x,y);
figure(5);imagesc(I_top), colormap(gray); title('I with imhmax'), axis equal
I_bot = imhmin(I_top, 50);
figure(6); imagesc(I_bot), colormap(gray); title('I with imhmin'), axis equal
figure(7); improfile(I_bot,x,y);
mine = imregionalmin(I_bot);
figure(8), imshow(mine),  title('I with imregionalmin'), axis equal

% 
% se = strel('disk', 20);
% I_closing = imclose(I_bot, se);
% figure(9); imagesc(I_closing-I_bot); colormap(gray);
% 





%% 4. Application 2
%
% In this section, the goal is to segment the cells present in the image
% 'erythrocytes.bmp' without inclusions(small black dots). The obtained 
% result must be similar to the one shown in erythrocytesBin.bmp.
%
% For this application, you can use any tools seen in the Chapter 5.

clear all;
close all;
I=imread('erythrocytes.bmp');
figure, imshow(I),colormap(gray), title('I'), axis equal

%improfile();
Ires=imread('erythrocytesBin.bmp');
figure, imshow(Ires),colormap(gray), title('Expected result'), axis equal


