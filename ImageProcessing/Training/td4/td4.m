%% TD4 - Traitement d'image - Détection de points d'intérêts
%
% L'objectif de cette séance est de retrouver automatiquement la 
% transformation géométrique qui a eu lieu entre 2 images d'une même scène.
% Nous allons d'abord travailler sur une transformation affine, puis 
% sur une homographie. Pour cela, nous allons extraire des descripteurs 
% (du type SIFT) de points d'intérêts et les mettre en correspondance entre
% les deux images étudiées.

%% 2.1 Extraction descripteurs SIFT

% nom image
im1_name = 'images\bear1.jpg';
im2_name = 'images\bear2.jpg';

% lecture image 1
im1=imread(im1_name);

% extraction des descripteurs sift sur image 1
[im1_sift, desc1, loc1] = sift(im1_name);
figure(1);imshow(im1); hold on;
plot(loc1(:,2), loc1(:,1),'+g'),hold off;

% nombre de descripteurs sift sur image 1
n1=size(desc1,1);

% lecture image 2
im2=imread(im2_name);

% extraction des descripteurs sift sur image 2
[im2_sift, desc2, loc2] = sift(im2_name);
figure(2);imshow(im2); hold on;
plot(loc2(:,2), loc2(:,1),'+g'),hold off;
% nombre de descripteurs sift sur image 2
n2=size(desc2,1);

% visualisation des points d'intérêts
figure(3);
subplot(1,2,1);
imshow(im1); title('image 1'); hold on
plot(loc1(:,2),loc1(:,1),'+g');
subplot(1,2,2);
imshow(im2); title('image 2'); hold on
plot(loc2(:,2),loc2(:,1),'+g');

%% 2.2 Comparaison des descripteurs SIFT

% distance entre descripteurs sift
tdist=zeros(n1,n2);
for i=1:n1
    for j=1:n2
        tdist(i,j)=norm(desc1(i,:)-desc2(j,:));
    end
end


% appariement des descripteurs sift
[dis, ind] = min(tdist);

%% 2.3 Calcul de la transformation affine
% $x' = a\,x + b\,y + c$ 
%%
% $y' = d\,x + e\,y + f$

x2 = [];
x1 = [];
for i=1:n2
    x2 = [x2 [loc2(i,1);loc2(i,2);1]];
    x1 = [x1 [loc1(ind(i),1);loc2(ind(j),2);1]];
end

% obtention de la transformée affine
T1 = x2*pinv(x1);

%% 2.4 Application de la transformation

imt1 = applique_transfo(im1,T1,size(im2));

figure;
subplot(1,3,1); imshow(im1); title('image 1');
subplot(1,3,2); imshow(imt1); title('image 1 transformÃ©e');
subplot(1,3,3); imshow(im2); title('image 2');
%%
% [interprétation résultat à compléter] 
%

%% 2.5 Calcul robuste de la transformation affine par l'algorithme RANSAC

% ransac
nb_step=1000;

for k=1:nb_step
    % sélection de points aléatoires
    i2 = ceil(rand(1,3)*n2);
    t2 = [];
    t1 = [];
    % coordonnées correspondantes
    for i=1:3
        t2 = [t2 [loc2(im2(i),1);loc2(im2(i),2);1]];
        t1 = [t1 [loc1(ind(im2(i)),1);loc1(ind(im2(i)),2);1]];
    end;
    % calcul de la transformée courante
    T=t2*pinv(t1);
    % nombre de correspondances vérifiant la transformée courante
    nbr(k) = length(find(sqrt(sum((x2-T*x1).^2))<6));
    % stockage de la transformée courante
    transf{k} = T;
end
% selection de la meilleure transformée
[y, index] = max(nbr);
T = transf{index};

% application de la meilleure transformation sur l'image 1
imt = applique_transfo(im1,T,size(im2));
x2t = T*x1;

% comparaison des résultats
figure;
imshow(im2); hold on
plot(loc2(:,2),loc2(:,1),'+g');
plot(x2t(2,:),x2t(1,:),'or');

figure;
subplot(2,2,1); imshow(im1); title('image 1');
subplot(2,2,2); imshow(im2); title('image 2');
subplot(2,2,3); imshow(imt1); title('image 1 transformée');
subplot(2,2,4); imshow(imt); title('image 1 transformée (ransac)');
%%
% [interprétation résultat à compléter] 

%% 2.6 Modélisation par une transformation affine et mosaïquage

% Remarque : code similaire à la partie précédente

clc;
close all;
clear all;

% nom image
im1_name = 'bar1';
im2_name = 'bar2';

% lecture image 1
% [à compléter]

% extraction des descripteurs sift sur image 1
% [à compléter]

% nombre de descripteurs sift sur image 1
% [à compléter]

% lecture image 2
% [à compléter]

% extraction des descripteurs sift sur image 2
% [à compléter]

% nombre de descripteurs sift sur image 2
% [à compléter]

% visualisation des points d'intérêts
figure;
subplot(1,2,1);
imshow(im1); title('image 1'); hold on
plot(l1(:,2),l1(:,1),'+g');
subplot(1,2,2);
imshow(im2); title('image 2'); hold on
plot(l2(:,2),l2(:,1),'+g');

% distance entre descripteurs sift
% [à completer]

% appariement des descripteurs sift
% [à compléter]

% calcul de la transformation affine
x2 = [];
x1 = [];
for i=1:n2
    x2 = % [à compléter]
    x1 = % [à compléter]
end;

% obtention de la transformée affine
% [à compléter]

% mosaïquage entre image 1 et image 2
imt1 = mosaic_affine(im1,T1,im2);

figure;
subplot(1,3,1); imshow(im1); title('image 1');
subplot(1,3,2); imshow(im2); title('image 2');
subplot(1,3,3); imshow(imt1); title('image mosaïque');

% calcul robuste de la transformation affine par l'algorithme RANSAC
nb_step=1000;

for k=1:nb_step
    % selection aléatoire de points
    i2 = ceil(rand(1,3)*n2);
    t2 = [];
    t1 = [];
    for i=1:3
        t2 = % [à compléter]
        t1 = % [à compléter]
    end;
    % calcul de la transformée courante
    % [à compléter]
    % nombre de correspondances vérifiant la transformée courante
    nbr(k) = length(find(sqrt(sum((x2-T*x1).^2))<6));
    % stockage de la transformée courante
    transf{k} = T;
end;
% selection de la meilleure transformée
% [à compléter]

% mosaïquage entre image 1 et image 2 avec la nouvelle transformation affine
imt = mosaic_affine(im1,T,im2);

% % comparaison résultats
% x2t = T*x1;
% figure;
% imshow(im2); hold on
% plot(l2(:,2),l2(:,1),'+g');
% plot(x2t(2,:),x2t(1,:),'or');

figure;
subplot(2,2,1); imshow(im1); title('image 1');
subplot(2,2,2); imshow(im2); title('image 2');
subplot(2,2,3); imshow(imt1); title('image mosaïque');
subplot(2,2,4); imshow(imt); title('image mosaïque (ransac)');
%%
% [interprétation résultat à compléter]

%% 2.7 Modélisation par une transformation homographique et mosaïquage
% [x' y' z']^T =  [H11 H12 H13 ; H21 H22 H23 ; H31 H32 H33] * [x y z]^T
%%
% x'' = x'/z' et y'' = y'/z' et z = 1 mènent à :
%%
% [expression théorique à compléter] = 0
%%
% [expression théorique à compléter] = 0
%%
% résolu par SVD

% normalisation
[x1n, T1] = normalise2dpts(x1);
[x2n, T2] = normalise2dpts(x2);

% calcul robuste de la transformation homographique par l'algorithme RANSAC
for k=1:nb_step
    % selection aléatoire de points
    i2 = ceil(rand(1,5)*n2);
    A = zeros(10,9);
    % coordonnées correspondantes
    for i=1:5
        A(1+2*(i-1),:) = % [à compléter]
        A(2+2*(i-1),:) = % [à compléter]
    end;
    % resolution systême --> obtention transforméee homographique
    [u,s,v] = svd(A);
    H = reshape(v(:,9),3,3)';
    % suppression normalisation
    H = T2\H*T1;
    x1hat = H*x1;
    x1hat = x1hat./repmat(x1hat(3,:),3,1);
    % nombre de correspondances vérifiant la transformée courante
    nbr(k) = length(find(sqrt(sum((x2-x1hat).^2))<6));
    % stockage de la transformée courante
    % [à compléter]
end;
% selection de la meilleure transformée
% [à compléter]
    
% mosaïquage entre image 1 et image 2 avec la nouvelle transformation homographique
imt = mosaic_homographie(im1,H,im2);
figure;
imshow(imt);

%%
% [interprétation résultats à compléter]
