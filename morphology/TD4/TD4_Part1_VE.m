%% Mathematical Morphology - Hit or Miss transforms
% Assignment 4 -- Part 1

% Nom : WU
% Prenom : Jinda

%***********************
%% Part 1: Homotopic thinnings and discrete skeleton
% Use of Matlab functions bwhitmiss and bwmorph

clear all;

A=imread('utk.tif');
A=A(85:150,:);
figure(1),imagesc(A), colormap(gray)

%% 1.1. Analyse function tse_bwthinning
%
% a) Open function tse_bwthinning.m and answer the following questions
%
%   * which structuring element family is used ?
%   * what is the purpose of the for loop ?
%   * which ending condition is used ?
%
% b) Run the fuction with nb = 3 and nb = Inf
%
%   * comment the result,
%   * what is the connexity of the result ?

BWA = tse_bwthinning(A , 3);
figure(2), imagesc(BWA), colormap('gray')

BWA = tse_bwthinning(A , inf);
figure(3), imagesc(BWA), colormap('gray')

BWA = bwmorph(A ,'skel', 3);
figure(4), imagesc(BWA), colormap('gray')
% Les branches apparaissent, meme role de fonction 'tes_bwthinning'
BWA = bwmorph(A ,'skel', inf);
figure(5), imagesc(BWA), colormap('gray')

BWA = bwmorph(A ,'spur', 2);
figure(6), imagesc(BWA), colormap('gray')

BWA = bwmorph(A ,'spur', inf);
figure(7), imagesc(BWA), colormap('gray')

BWA = bwmorph(BWA ,'spur', inf);
figure(8), imagesc(BWA), colormap('gray')
% if we want to clear spur, there must be spurs, and the original image
% must be binaire, the third parametre is inf.

%% 1.2. Compare the result obtained with bwmorph command with the 'skel' option
%
% Use 3 and Inf for the third parameter.
%
BWB = bwmorph(A, 'thin', 3);
figure(9),imagesc(BWB); axis square;colormap('gray');
BWB = bwmorph(A, 'thin', inf);
figure(10),imagesc(BWB); axis square;colormap('gray');

BWB = bwmorph(BWB, 'spur', inf);
figure(11), imagesc(BWB);axis square; colormap('gray');
%   * what is the difference with tse_bwthinning ?
%   * give a possible explanation.

BWA = bwmorph(BWA,'endpoints' ,3);
figure(12), imagesc(BWA),colormap('gray')

% just show these endpoints
BWA = bwmorph(BWA,'endpoints' ,inf);
figure(13), imagesc(BWA),colormap('gray')


%% 1.3 Pruning
%
% Find the Matlab option allowing to prune a skeleton. Then, compute the skeleton of the input image
% and prune it using different values (1, 2, 8). 

BWA=bwmorph(A,'skel',Inf);
BWB = bwmorph(BWA,'spur',1);
figure(14), imagesc(BWB) ;axis square;colormap('gray')



BWB = bwmorph(BWA,'spur',2);
figure(14), imagesc(BWB) ;axis square;colormap('gray')


BWB = bwmorph(BWA,'spur',8);
figure(14), imagesc(BWB) ;axis square;colormap('gray')

%%
% *Comment the result:*
%
% Now prune the skeleton till infinity. What do you get and why ?


%% 1.5. Conclusion:
