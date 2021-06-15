% TD3 : Grayscale morphological filtering
% 
% Nom : WU
% Prénom :Jinda
% Groupe TD :7a

%% Exercise 1 : Uneven background correction

I=imread('images/unevenbackground.tif');
figure(1),imshow(I)


% Code :

level = graythresh(I);
Imbw = im2bw(I, level);
figure(2)
imshow(Imbw);

% subplot(1, 2, 1)
% imshow(I);title("Imgae original");
% subplot(1, 2, 2)
% imshow(Imbw);title("2bw with level graythresh(I)")
% Can this be done using a global threshold? NO

SE = strel('disk', 20);
IO = imopen(I, SE);
figure(3)
imshow(IO);title("open image")

Tophat = I - IO;
figure(4)
imshow(Tophat);title("Top-hat operation")

Tophat_bin = im2bw(Tophat, level);
imshow(~Tophat);  
            
            




%% Exercise 2 : Defects segmentation
close all;
I2=rgb2gray(imread('images/microcircuit.jpg'));
figure(1), imshow(I2)


x=[111,111];
y=[39,139];
line(x,y,'Color','red')
figure(2),improfile(I2,x,y), title('vertical profile')

x=[75,165];
y=[39,39];
figure(1), line(x,y,'Color','red')
figure(3),improfile(I2,x,y), title('horizontal profile')

% Code :
% Comment all steps of your approach (SE, operation, result) :
SE = strel('line', 20, 90);
I2C = imclose(I2, SE);
figure(4)
imshow(I2C); title("Image2 closing")

Tophatcon = I2C - I2;
figure(5)
imshow(Tophatcon);title("Top-hat conjuge")

level = graythresh(Tophatcon);
Imbw = im2bw(Tophatcon, 0.3);
figure(6)
imshow(Imbw)

Thc = bwareaopen(Imbw, 5);
figure(7)
imshow(Thc)

%pour mettre en rouge
I2 = I2+1;
I2(Thc == 1) = 0;
map = gray(256);
map(1,:) = [1, 0, 0];
figure(8)
imshow(I2, map);title("resultat detection");



%%  Exercise 3

% Some code elements : 

% % granulometry analysis
% for counter = .....
%     remain = ....(I, strel('disk', counter));
%     surfarea(counter + 1) = sum(remain(:));  
%     %imshow(remain), pause   % use this line to visualize the results
% end
% figure, plot(surfarea, 'm - *'), grid on;
% set(gca, 'xtick', [0 2 4 6 8 10 12 14 16 18 20]);
% title('Surface area of ...... objects as a function of radius');
% xlabel('radius of ......... (pixels)');
% ylabel('surface area of ......... objects (pixels)');
% 
% % Calculate First Derivative
% derivsurfarea = diff(surfarea);
% figure, plot(derivsurfarea, 'm - *'), grid on;
% title('Granulometry (Size Distribution) of Objects');
% xlabel('radius of ........(pixels)');
% ylabel('loss of pixels between two successive ..........');


%% Case 1: automatic size determination on binary objects: circles.jpg
close all;
clear all;
I = im2bw(imread('images/circles.jpg'));
figure(1), imshow(I), title('original image')


for counter = 1: 10
    remain = imopen(I, strel('disk', counter));
    surfarea1(counter + 1) = sum(remain(:));  
    imshow(remain), pause  % use this line to visualize the results
end

figure(2)
subplot(2,1,1), plot(0:10,surfarea1, 'm - *'), grid on;
set(gca, 'xtick', [0 2 4 6 8 10 12 14 16 18 20]);
title('Surface area of ...... objects as a function of radius');
xlabel('radius of ......... (pixels)');
ylabel('surface area of ......... objects (pixels)');

% Calculate First Derivative
derivsurfarea = diff(surfarea1);
figure, plot(derivsurfarea, 'm - *'), grid on;
title('Granulometry (Size Distribution) of Objects');
xlabel('radius of ........(pixels)');
ylabel('loss of pixels between two successive ..........');

%% Case 2: automatic size determination on binary objects: circleLines.jpg
close all;
I = im2bw(imread('../images/circlesLines.jpg'));
figure(1), imshow(I), title('original image')

% First, observe the data. What is the difference between this second case image and the first
% studied one ? 


%% Case 3: automatic size determination on binary objects: GranBin.png
close all;
I = im2bw(imread('../images/GranBin.png'));
figure(1), imshow(I), title('original image')


%% Case 4: studying textures 
clear all;
I = imread('../images/wall_0.png');
I1= imread('../images/wall_1.png');
I2= imread('../images/wall_2.png');
figure(1), imshow(I), title('original image')
figure(2), imshow(I1), title('original image 2')
figure(3), imshow(I2), title('original image 3')


