%% Canevas TD2 - Morphologie Mathématique

% Nom : WU
% Prénom :Jinda
% Groupe TD :7a

close all;

%% Exercice 1 : corner extraction

%  Reading the image : complete the code so as to get a binary image with a
%  white tree and black background 
I=im2bw(imread('images/tree.jpg'));
I=~I;
figure(1)
imshow(I);

% Comment all steps of your approach (SE, operation, result) to extract corners:

SE = strel('disk', 3);

% Result image

IO = imopen(I, SE);
figure;
imshow(IO);title('image opening')
% 
% IC_test = imclose(I, SE);
% figure;
% imshow(IC_test);title('image closin g')


diffIO = I - IO;
figure;
imshow(diffIO);title('image - image opening')


IC = imclose(I, SE);
figure;
imshow(IC);title('image closing')
diffIC = IC - I;
figure;
imshow(diffIC);title('image closing - image')

Ires = diffIO + diffIC;

figure(6)
imshow(Ires),title('image corners !')


%% Exercice 2 : diagonal dashed lines detection

close all;

% Reading the image 
I=rgb2gray(imread('images/dashedLines.bmp'));
figure(1)
imshow(I)

% Comment all steps of your approach (SE, operation, result) to segment dashed lines:
SE = strel('line', 10, 45);
Im45 = imclose(I, SE);
% im45 = imdilate(I, SE);
% Im45 = imerode(im45, SE);
figure;

% imshow(im45);title('image closing')
imshow(Im45);title('image closing')

SE = strel('line', 20, 45);

% Result image
Ires= imerode(Im45, SE);
figure(3)
imshow(Ires),title('segmented lines !')


%% Exercice 3 : decompose a binary image of a circuit board in its main components

close all;

% Reading the image 
I=im2bw(imread('images/circuit.jpg'),0.2);
figure(1),imshow(I)

%% Segmentation of holes

% Comment all steps of your approach (SE, operation, result):

SE = strel('disk', 5);

% Result image

IC = imclose(I, SE);
figure;
imshow(IC);title('image closing')
diffIC = IC - I;
figure;
imshow(diffIC);title('image closing - image');

Iholes=bwareaopen(diffIC, 10);
figure(4)
imshow(Iholes), title('Segmented holes')

% Visualization

% Create a black rgb image
[m,n]=size(I);
Iv=zeros(m,n,3,'uint8');
% Set original image in white
idx=find(I>0);
Iv(idx)=255;
Iv(m*n+idx)=255;
Iv(2*m*n+idx)=255;
% Set holes to yellow
idx=find(Iholes>0);
Iv(idx)=255;
Iv(m*n+idx)=255;
Iv(2*m*n+idx)=0;

figure(5)
imshow(Iv),title('Final composition image')


%% Segmentation of square islands

% Comment all steps of your approach (SE, operation, result):
SE = strel('square', 17);
Imcom = I + Iholes;
IOS = imopen(Imcom, SE);
figure;
imshow(IOS);

% Result image


Isq=(~Iholes).*IOS;
figure(4)
imshow(Isq),title('square with holes')

% Visualization
% Set square islands to red
idx=find(Isq>0);
Iv(idx)=255;
Iv(m*n+idx)=0;
Iv(2*m*n+idx)=0;

figure(5)
imshow(Iv),title('Final composition image')


%% Segmentation of circle islands

% Comment all steps of your approach (SE, operation, result):

SE = strel('disk', 8);
Imcom = I + Iholes;
IOC = imopen(Imcom, SE);
figure;
imshow(IOC);

diffIOC = bwareaopen(IOC, 5);
figure;
imshow(diffIOC);
% Result image
Icirc=
figure(4)
imshow(Icirc); title('circular island with holes')

% Visualization
% Set circle islands to green
idx=find(Icirc>0);
Iv(idx)=0;
Iv(m*n+idx)=255;
Iv(2*m*n+idx)=0;

figure(5)
imshow(Iv),title('Final composition image')


%% Segmentation of rectangular islands

% Comment all steps of your approach (SE, operation, result):
SE = strel('rectangle', 10.1);
Imcom = I + Iholes;
IOR = imopen(Imcom, SE);
figure;
imshow(IOR);

% Result image
Irect=
figure(4)
imshow(Irect); title('rectangular island with holes')

% Visualization
% Set rectangular islands to blue
idx=find(Irect>0);
Iv(idx)=0;
Iv(m*n+idx)=0;
Iv(2*m*n+idx)=255;

figure(5)
imshow(Iv),title('Final composition image')



