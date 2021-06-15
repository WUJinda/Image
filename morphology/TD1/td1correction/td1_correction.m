% TD1 : Erosion, covariance et analyse de texture

clear all
close all


%% 1. D�finition de l'op�rateur covarience

%% Questions
% 1. Rappeler le sens math�matique de la notion de covariance. 
% 2. Quelle information cherche-t-on � obtenir lorsque l'on mesure la covariance d'une image ?
% 3. Repr�senter les �l�ments P_{1,(1,0)}, P_{1,(2,0)}, P_{1,(1,1)}, P_{1,(1,2)}.
% 4. Expliquer le principe de la mesure de covariance $K$ donn�e ci-dessus. 


%% 2. Application � l'analyse de texture

%% Chargement de l'image

f=imread('Images/tirets.png');
figure(1)
imshow(f);

%% Erosion par un bipoint

% Construction de l'�l�ment structurant "pair de points"
s=strel('pair',[0 30]);
% Calcul de l'image �rod�e
fer=imerode(f,s);
% Calcul du volume de l'image
k=sum(fer(:))

figure(2)
imshow(fer);

%% S�rie d'�rosions successives

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
 
% 1. Commenter et expliquer les Fig. 3.22b et 3.22c (en s'appuyant sur des sch�mas �ventuellement).
% 2. Est-ce que la Fig. 3.22b pourrait �tre utilis�e pour effectuer une soustraction de fond ? 
% 3. Que repr�sente la Fig. 3.23 ?
% 4. D'apr�s le texte, quelle information recherche-t-on avec ce graphique ? 
% 5. A l'aide du texte et de la Fig. 3.22, commenter la Fig. 3.23
%    (donner des �l�ments quantitatifs sur la texture - Pourquoi, entre 2 pics, les valeurs ne sont pas nulles ?
%    Pourquoi les pics d�croissent ? Pourquoi observet-on une p�riodicit� interm�diaire ?)
% 6. Expliquer pourquoi une information de taille des �l�ments de la texture peut �tre d�duite
%    de la pente du covariogramme � l'origine.


%% 3. Analyse selon l'orientation

%% Image de grille

clear all;
close all;

f=imread('Images/grille.png')>0;
figure(1)
imshow(f);

%% Erosion par un bipoint d'une orientation donn�e

% Calcul du vecteur d�finissant le bipoint
angle=30;
d=10;
v=round(d.*[sin(-pi*angle/180) cos(pi*angle/180)]);

% Calcul de l'�l�ment structurant
s=strel('pair',v);
% Calcul de l'image �rod�e
fer=imerode(f,s);
% Calcul de la surface de l'image
k=sum(fer(:));

figure(2)
imshow(fer);

%% S�rie d'�rosions successives

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

% 1. D'apr�s le texte, comment utiliser la covariance pour obtenir une information
%    d'orientation des structures de l'image?
% 2. Que repr�sente la Fig. 3.24b ? Pourquoi parle-t-on d'aire et non plus de volume ?
% 3. D'apr�s le graphique 3.24b, quelles sont les orientations principales de la Fig. 3.24a ?
% 4. Quelle est l'influence du param�tre d'�cart du bipoint ?


