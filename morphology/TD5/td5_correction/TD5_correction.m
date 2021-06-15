%% Mathematical Morphology - Grayscale morphological reconstruction
% Assignment 5
%
%  Nom : 
%  Prénom : 
%
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

figure(2)
RegMax=imregionalmax(A);
imagesc(RegMax), colormap(gray);

%%% 
% Comment:
%
% What is the type of the result image ?
%
% Answer:
%
% On obtient une image binaire avec plusieurs max régionaux. On n'a plus
% d'information sur l'amplitude des max régionaux


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
% Answer : on n'a plus que 2 maxima. Les autres ont été filtrés en fonction
% du contraste. 



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
% Specifying a threshold value of 2. Note that imhmax only affects the maxima;
% none of the other pixel values are changed. The two significant maxima remain,
% although their heights are reduced.

%%%
% *2.3*
%
% The simple image C contains two primary regional maxima, the blocks of pixels containing 
% the values 14 and 18, and several smaller maxima, set to 11. One pixel of the regional
% maximum of value 14 is corrupted(pohuai) by noise and set to 1. 


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

C1=imhmax(C,6)
figure(8)
imagesc(C1), colormap(gray);

C2= C - C1
figure(9)
imagesc(C2), colormap(gray);

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

D2=imhmin(D,10) ; % avec 6, on supprime le min à 18, avec 10, on supprime le min de 14
figure(11)
imagesc(D2), colormap(gray)

%%%
% *2.4.b)*
%
% Comment:
%
% On réhausse cette fois les creux. avec 6, on supprime le min à 18, avec
% 10, on supprime le min de 14.


%%
% *2.5*
%
% The simple image E contains one primary regional minima with a noisy pixel set to 12 instead of 14. 

E= [24 24 24 24 24 
    24 14 14 14 24 
    24 14 14 14 24 
    24 14 12 14 24 
    24 24 24 24 24 
    24 24 24 24 24 ] ;

%%%
% Eliminate the noisy pixel, varying the parameter h between 1, 2, 3
% and 4. Check the resulting values for each h parameter.

%%%
% *2.5.a)*

% Code:

figure(12)
imagesc(E), colormap(gray)
E2=imhmin(E,1) 
figure(13)
imagesc(E2), colormap(gray)

E2=imhmin(E,2) 
figure(14)
imagesc(E2), colormap(gray)

E2=imhmin(E,3) 
figure(15)
imagesc(E2), colormap(gray)

E2=imhmin(E,4) 
figure(16)
imagesc(E2), colormap(gray)

%%%
% *2.5.b)*
% 
% Comment:
%
% On réhausse cette fois les creux. On part bien du point le plus bas de la vallée, et
% on réhausse les valeurs du creux progressivement. 


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
figure(1), imagesc(I),colormap(gray), title('I'), axis equal

%%%
% *3.1. Analysis of the input image*
%
% *3.1.1. Extract all regional minima using imregionalmin*

% Code : 

Iminr = imregionalmin(I);
figure(2)
imshow(Iminr);

%%%
% Comment :  many regional minima


%%%
% *3.1.2. Extract all regional maxima using imregionalmax.*

% Code : 

Imaxr = imregionalmax(I);
figure(3)
imshow(Imaxr);

%%%
% Comment :  many regional maxima
%
% To understand the previous results, let's plot a profile.

figure(4), imagesc(I),colormap(gray), title('I'), axis equal
%c=improfile() %(2,83,210,83)
% ou
 x = [2 210];
 y = [83 83];
 improfile(I,x,y);

%%%
% What do you observe ?
%
% * dérive d'éclairement
% * bruit 

%%%
% *3.1.2. Image segmentation*
%
% Propose a sequence of processing steps to obtain a binary image
% with the round objects. (you can plot the same profile to understand
% the result of your operations)

% Code:

Ihmin = imhmin(I,20);  %musc 10  blobs :10
figure(5),imagesc(Ihmin),colormap(gray), title('Résultat de hmin avec h=20'), axis equal
figure(6),improfile(Ihmin,x,y);

Ihmin = imhmin(I,40);  %musc 10  blobs :10
figure(7),imagesc(Ihmin),colormap(gray), title('Résultat de hmin avec h=40'), axis equal
figure(8),improfile(Ihmin,x,y);

Ihminmax = imhmax(Ihmin,40);  %musc 10  blobs :10
figure(9),imagesc(Ihminmax),colormap(gray), title('Résultat de hmax avec h=40'), axis equal
figure(10),improfile(Ihminmax,x,y);

% avec hmin, on remplit les vallées noires
% Extraction des maxima régionaux
mine = imregionalmin(Ihmin);
figure(11), imshow(mine), title('mine')

% on peut faire une petite fermeture pour boucher les trous
B=strel('disk',1);
minecl = imclose(mine,B);
figure(12), imshow(minecl), title('minecl')



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

figure(1), imshow(I),colormap(gray), title('I')
%improfile();
Ires=imread('erythrocytesBin.bmp');

figure(2), imshow(Ires),colormap(gray), title('Expected result')


%%
% *1ère solution :*  On commence par supprimer les pics lumineux au centre
% des cellules par une ouverture par reconstruction.

B=strel('disk',25);
Iop = imerode(I,B);
Iopr = imreconstruct(Iop,I);
figure(3),imagesc(Iopr),colormap(gray), title('Résultat de ouverture par reconstruction'), axis equal
%improfile();

% filtrage des inclusions noires
B=strel('disk',10);
Ioprcl = imclose(Iopr,B);
Ioprclth = Ioprcl > 200;
figure(4),imagesc(Ioprclth),colormap(gray), title('Expected result'), axis equal


%%
% *2ème solution* : pour cette application, on peut utiliser hmin/hmax pour
% lisser, puis fermeture des points noirs, comme on vient de le faire. 

% Meilleure stratégie pour avoir les cellules et leurs zones de superposition. 
% --> détection du fond après lissage! 
B=strel('disk',9);
Icl = imclose(I,B);
figure(45),imagesc(Icl),colormap(gray)
Iclmaxr = imregionalmax(imhmax(Icl,29));
figure(5),imagesc(Iclmaxr),colormap(gray),% title('Résultat de la reconstruction à partir du fond.'), axis equal

%%%
% Ensuite, sur ce résultat, il faut trouver comment déconnecter les objets
% (ce qui peut servir d'image d'entrée au TD suivant). En effet, les objets
% peuvent être déconnectés par LPE.



%% 5. Cell segmentation
%
% Here is an image of blood cells:

clear all
close all

i=imread('blood.tif');
i=rgb2gray(i);
figure(1)
imshow(i,[])

%%%
% Notice the cell roughly in the middle, it's a white blood cell with
% it's cell nucleus stained.  We want to get ONLY this one cell
%
% Propose a morphological sequence of operations to get the cell :

% Hmmmmmmm, let's try a thresholding:

it1=i<100;
figure(2)
imshow(it1,[])

% No luck, this gives us just the nucleus.  Let's change threshold

it2=i<180;
figure(3)
imshow(it2,[])

% This gives us roughly what we want, but notice that now we got many other
% cells too.

% Reconstruction to our aid.  Start by thresholding to make a really strict
% marker for the nucleus (we also use an opening to remove some noise)

it1=i<100;
it1=imopen(it1,ones(5));
figure(4)
imshow(it1,[])

% Now lets make a very "loose" threshold

it2=i<180;
figure(5)
imshow(it2,[])

% Now reconstruct the marker under the mask using dilation.

ir=imreconstruct(it1,it2);
figure(6)
imshow(ir,[])

% Lets finish this off by a closing to remove a few interior holes

ir=imclose(ir,ones(3));
figure(7)
imshow(ir,[])

% here  a nice trick to put a red border around our cell
% suppose your result binary image is named ir

irb=bwperim(ir,8);
i(find(irb))=255;
figure(8)
imshow(i,[])

%modification de la lut
map=gray(256);
map(256,:)=[1 0 0];
colormap(map)

