%% Mathematical Morphology - Hit or Miss transforms
% Assignment 4 -- Part 1
%
%  Nom : 
%  Pr�nom : 

%% Part 1: Homotopic thinnings and discrete skeleton
% Use of the Matlab function bwmorph

clear all

A=imread('utk.tif');
A=A(85:150,:);
[m,n]=size(A);
figure(1),imagesc(A), colormap(gray)
[m,n]=size(A);


%% 1.1. Observe the result of the bwmorph command with the 'skel' option
% Varying the third parameter (for instance, take, 3 and Inf)
%
% What is the connexity of the result ?

BWA = bwmorph(A,'skel',2);
figure(2), imagesc(BWA), axis square;colormap('gray')

% BWA = bwmorph(A,'spur',Inf);
% figure(2), imagesc(BWA), ;axis square;colormap('gray')
   % si on applique l'option spur � l'infini sur l'image initiale, on
   % conserve l'image car pas de branches � nettoyer. 

BWA = bwmorph(A,'skel',Inf);
figure(3), imagesc(BWA), ;axis square;colormap('gray')


%BWA = bwmorph(BWA,'spur',Inf);
%figure(3), imagesc(BWA), ;axis square;colormap('gray')
   % si on applique l'option spur � l'infini sur le squelette, on
   % conserve un pixel allum� par objet . --> homotopie !


%%
% *Comment the results :*
%
% * 3: amincissement homotopique de la forme (connexit� V8)
% * Inf: on obtient un squelette homotopique avec une connexit� v8 pour l'objet. 
%
% On observe des branches parasit�s au niveau du U du fait de la
% num�risation.


%% 1.2. Compare the result obtained with the 'thin' option ? (take 3 and Inf)

BWB = bwmorph(A,'thin',3);
figure(4), imagesc(BWB), ;axis square;colormap('gray')

BWB = bwmorph(A,'thin',Inf);
figure(5), imagesc(BWB), ;axis square;colormap('gray')

% 
%  BWB = bwmorph(BWB,'spur',Inf);
%  figure(5), imagesc(BWB), ;axis square;colormap('gray')
               % spur sur le r�sultat de thin renvoie les pixels pour chaque objet.   


%%
% ici, le r�sultat est diff�rent. La branche parasite qui apparaissait en
% bas du U est supprim�e. En fait, le squelette obtenu par 'skel' est �barbul�. Le r�sultat 
% n'est pas calcul� avec la m�me famille d'�l�ments structurants.  
% La famille d'�l�ments structurants n'est pas la m�me.


%% 1.3. Pruning
%
% Find the Matlab option allowing to prune a skeleton. Then, compute the skeleton of the input image
% and prune it using different values (1, 2, 8).

BWA=bwmorph(A,'skel',Inf);
BWB = bwmorph(BWA,'spur',8);
figure(6), imagesc(BWB), ;axis square;colormap('gray')

%%
% *Comment the result :*
%
% On raccourcit les branches parasites progressivement, pour nettoyer les artefacts. 
%
% Now prune the skeleton till infinity. What do you get and why ?

BWA=bwmorph(A,'skel',Inf);
BWB = bwmorph(BWA,'spur',Inf);
figure(7), imagesc(BWB), ;axis square;colormap('gray')

%%
% *Comment the result :*
%
% On raccourcit les branches parasites progressivement, pour nettoyer les artefacts. 


%% 1.5. Conclusion:
%
% Le squelette n'est pas unique. Selon l'algo et la famille d'�l�ments
% structurants, le squelette change. Dans une appli de reco de formes, 
% il est essentiel de travailler avec le m�me algorithme.
