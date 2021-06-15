%% Mathematical Morphology - Hit or Miss transforms
% Assignment 4 - Part 2

% Nom : 
% Prénom : 

%% Application 1

clear all;
close all;
I=imread('elipses.bmp');
figure(1);imshow(I);

BWsk=bwmorph(I,'skel',Inf);
figure(2), imshow(BWsk);title('skeleton');

BWpruning = bwmorph(BWsk,'spur',15);
figure(3), imagesc(BWpruning) ;axis square;colormap('gray')



%% Application 2

clear all;close all;
I=imread('pieces.bmp');
figure(1);imshow(I);

% Rings detection
BWsk=bwmorph(I,'skel',Inf);
figure(2), imshow(BWsk);title('skeleton');

BWpruning = bwmorph(BWsk,'spur',inf);
figure(3), imagesc(BWpruning) ;axis square;colormap('gray')


% filtering of small isolated objects
skprao=bwareaopen(BWpruning,5);
figure(4), imshow(skprao), title('pruned skeleton after filtering of small objects');

% reconstruction
res=imreconstruct(skprao,I);
figure(5), imshow(res), title('Rings reconstruction');

%T pieces detection

I2 = I - res;
figure(6),imshow(I2),title('T pieces and nails');

% use the convex hull
ch = bwconvhull(I2, 'objects');
figure(7), imshow(ch), title('convex hull');


skprao=bwareaopen(ch,850);
figure(8), imshow(skprao), title('CONVEX HULL filtered if area <850 pixels');

% reconstruction
ch2= skprao.*I2;
figure(9), imshow(ch2), title('identified T');


I3 = I2-ch2;
figure(10), imshow(I3), title('identified nails');
