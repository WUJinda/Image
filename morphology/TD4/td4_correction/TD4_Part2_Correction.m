%% Mathematical Morphology - Hit or Miss transforms
% Assignment 4 - Part 2 
%
%  Nom : 
%  Prénom : 

%% Application 1

clear all;
close all;

I=imread('elipses.bmp');
figure(1);imshow(I)


sk=bwmorph(I,'skel',Inf);
figure(2), imshow(sk), title('Skeleton');

% pruning
skpr=bwmorph(sk,'spur',15);
figure(3), imshow(skpr), title('pruned Skeleton');

%%%
% The operator will cut each object by their ending points the necessary to clear only the small ones. The parameter N is set accordingly to the length of the small objects. 
% filtering of small isolated objects

skprao=bwareaopen(skpr,10);
figure(4), imshow(skprao), title('pruned skeleton after filtering of small objects');

% reconstruction
res=imreconstruct(skprao,I);
figure(5), imshow(res), title('Elipse reconstruction');

%%%
% *Remarque :* les objets disque et carré ont été ajoutés pour que
% l'opération filtrage par aire ne fonctionne pas directement sur 
% les objets

skprao2=bwareaopen(I,150);
figure(6), imshow(skprao2), title('Area openning on the original image');



%% Application 2

clear all;close all;
I=imread('pieces.bmp');
figure(1);imshow(I)

%%
% *Ring pieces*

sk=bwmorph(I,'skel',Inf);
figure(2), imshow(sk), title('Skeleton');

% pruning
skpr=bwmorph(sk,'spur',Inf);
figure(3), imshow(skpr), title('pruned Skeleton');

% filtering of small isolated objects
skprao=bwareaopen(skpr,5);
figure(4), imshow(skprao), title('pruned skeleton after filtering of small objects');

% reconstruction
res=imreconstruct(skprao,I);
figure(5), imshow(res), title('Rings reconstruction');

%%
% *T pieces detection*

I2=I-res;
BW = I2>0.1;
figure(6), imshow(BW), title('T pieces and nails');

%%
% *1ère solution basée sur l'enveloppe convexe*

ch = bwconvhull(BW, 'objects');
figure(7), imshow(ch), title('convex hull');

skprao=bwareaopen(ch,850);
figure(8), imshow(skprao), title('CONVEX HULL filtered if area <850 pixels');

% reconstruction
ch2= skprao.*I2;
figure(9), imshow(ch2), title('identified T');


%%
% *2ème solution basée sur le squelette*

sk=bwmorph(I2,'skel',Inf);
figure(10), imshow(sk), title('Skeleton');

% pruning
skpr=bwmorph(sk,'spur',5);
figure(11), imshow(skpr), title('pruned Skeleton');
% on nettoie les petites branches artefacts pour n'avoir plus que des
% jonctions T correspondant aux objets recherchés.

% test du filtrage par aire (celui ne doit pas permettre de séparer objet
% en T des clous)
% skpr2=bwareaopen(sk,80);
% figure, imshow(skpr2), title('pruned skeleton after filtering of small objects');
% OK bwereaopen ne permet plus de séparer objets en T des autres

%%
% Filtering of small isolated objects

skprao=bwareaopen(skpr,5);
figure(12), imshow(skprao), title('pruned skeleton after filtering of small objects');

%%
% *Using matlab detection of triple points*

skprao1=bwmorph(skprao,'thin',5);   % First a little thinning
figure(12), imshow(skprao1), title('pruned skeleton after filtering of small objects');
skpraobp=bwmorph(skprao1,'branchpoints');
figure(13), imshow(skpraobp), title('branch points detection');

%%
% *Using tailored structuring element pairs*

B{1} =      [   -1  1 -1   ;...
                 1  1  1   ;...
                -1 -1 -1   ];

B{2} =      [    1 -1  1   ;...
                -1  1 -1   ;...
                -1 -1  1   ];

B{3} =      [   -1  1 -1   ;...
                -1  1  1   ;...
                -1  1 -1   ];

B{4} =      [   -1 -1  1   ;...
                -1  1 -1   ;...
                 1 -1  1   ];

B{5} =      [   -1 -1 -1   ;...
                 1  1  1   ;...
                -1  1 -1   ];

B{6} =      [    1 -1 -1   ;...
                -1  1 -1   ;...
                 1 -1  1   ];

B{7}    = [   -1  1 -1   ;...
                 1  1 -1   ;...
                -1  1 -1   ];

B{8}    = [    1 -1  1   ;...
                -1  1 -1   ;...
                 1 -1 -1   ];

B{9}    =  [   -1  1 -1   ;...
                -1  1  1   ;...
                 1 -1 -1   ];

B{10}    =   [   -1 -1  1   ;...
                 1  1 -1   ;...
                -1 -1  1   ];

B{11}    =   [    1 -1 -1   ;...
                -1  1  1   ;...
                -1  1 -1   ];

B{12}    =   [   -1  1 -1   ;...
                -1  1 -1   ;...
                 1 -1  1   ];

B{13}    =   [   -1 -1  1   ;...
                 1  1 -1   ;...
                -1  1 -1   ];

B{14}    =  [    1 -1 -1   ;...
                -1  1  1   ;...
                 1 -1 -1   ];

B{15}    =  [   -1  1 -1   ;...
                 1  1 -1   ;...
                -1 -1  1   ];

B{16}    = [  1 -1  1   ;...
             -1  1 -1   ;...
             -1  1 -1   ];


ptstriples=zeros(size(skprao)); 
figure(14)

   for i=1:16,
      ptstriples=ptstriples+bwhitmiss(skprao,B{i}); 
      imshow(ptstriples)
      disp(['B' int2str(i) ' applied, press any key to continue ... '])
      %pause
   end
   disp(['********  # of passes = ' int2str(i)]);

%%
% reconstruction à partir des points triples

res2=imreconstruct(double(ptstriples),double(I));
figure(15), imshow(res2), title('T reconstruction');


%%
% *Detection des derniers objets*

res3=I - res - res2;
figure(16), imshow(res3), title('Nail objects');



