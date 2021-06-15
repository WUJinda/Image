% TD1 : Erosion, covariance et analyse de texture

clear all
close all


%% 1. Définition de l'opérateur covarience

%% Questions
% 1. Rappeler le sens mathématique de la notion de covariance. 
% 2. Quelle information cherche-t-on à obtenir lorsque l'on mesure la covariance d'une image ?
% 3. Représenter les éléments P_{1,(1,0)}, P_{1,(2,0)}, P_{1,(1,1)}, P_{1,(1,2)}.
% 4. Expliquer le principe de la mesure de covariance $K$ donnée ci-dessus. 


%% 2. Application à l'analyse de texture

%% Chargement de l'image

f=imread('Images/tirets.png');
figure(1)
imshow(f);

%% Erosion par un bipoint

% Construction de l'élément structurant "pair de points"
s=strel('pair',[0 30]);
% Calcul de l'image érodée
fer=imerode(f,s);
% Calcul du volume de l'image
k=sum(fer(:))

figure(2)
imshow(fer);

%% Série d'érosions successives

n=50;
kf=zeros(1,n);

figure(3)
hold on

i=1;
for d=0:n
   s=strel('pair',[0,d]);
   fer=imerode(f,s);
   kfc=sum(fer);
   kf(i)=sum(kfc(1:end-d));
   i=i+1;
   imshow(fer)
   %pause(1)
end

hold off
figure(4)
plot(0:n,kf)
grid on

%% Questions
 
% 1. Commenter et expliquer les Fig. 3.22b et 3.22c (en s'appuyant sur des schémas éventuellement).
% 2. Est-ce que la Fig. 3.22b pourrait être utilisée pour effectuer une soustraction de fond ? 
% 3. Que représente la Fig. 3.23 ?
% 4. D'après le texte, quelle information recherche-t-on avec ce graphique ? 
% 5. A l'aide du texte et de la Fig. 3.22, commenter la Fig. 3.23
%    (donner des éléments quantitatifs sur la texture - Pourquoi, entre 2 pics, les valeurs ne sont pas nulles ?
%    Pourquoi les pics décroissent ? Pourquoi observet-on une périodicité intermédiaire ?)
% 6. Expliquer pourquoi une information de taille des éléments de la texture peut être déduite
%    de la pente du covariogramme à l'origine.


%% 3. Analyse selon l'orientation

%% Image de grille

clear all;
close all;

f=imread('Images/grille.png')>0;
figure(1)
imshow(f);

%% Erosion par un bipoint d'une orientation donnée

% Calcul du vecteur définissant le bipoint
angle=30;
d=10;
v=round(d.*[sin(-pi*angle/180) cos(pi*angle/180)]);

% Calcul de l'élément structurant
s=strel('pair',v);
% Calcul de l'image érodée
fer=imerode(f,s);
% Calcul de la surface de l'image
k=sum(fer(:));

figure(2)
imshow(fer);

%% Série d'érosions successives

delta=5;
d=10;
angle=-90:delta:90;
n=size(angle,2);
kf=zeros(1,n);

figure(3)
hold on

i=1;
for a = angle
   v=round(d.*[sin(-pi*a/180) cos(pi*a/180)]);
   s=strel('pair',v);
   fer=imerode(f,s);
   kf(i)=sum(fer(:));
   i=i+1;
   
   imshow(fer)
   pause(1)
end

hold off
figure(4)
plot(angle,kf)
grid on


%% Questions

% 1. D'après le texte, comment utiliser la covariance pour obtenir une information
%    d'orientation des structures de l'image?
% 2. Que représente la Fig. 3.24b ? Pourquoi parle-t-on d'aire et non plus de volume ?
% 3. D'après le graphique 3.24b, quelles sont les orientations principales de la Fig. 3.24a ?
% 4. Quelle est l'influence du paramètre d'écart du bipoint ?


