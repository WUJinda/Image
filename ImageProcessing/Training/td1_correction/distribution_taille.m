function h=distribution_taille(f,hauteur_image,classes)
% Calcul de la distribution de taille d'objets dans une image
% Retourne un histogramme
% Fonction appell�e dans td1_correction

%% Correction d�rive de fond
s=strel('disk',30);
f1=imclose(f,s)-f;

%% Binarisation
fbin=tse_imthreshold(f1,1,'entropy');

%% S�paration objets
fbin2=tse_imsplitobjects(fbin);

%% Ouverture + suppression bords
s=strel('disk',1);
fbin3=imopen(fbin2,s);
fbin3=imclearborder(fbin3);

%% Labelisation
[fe,n]=bwlabel(fbin3);
fe_rgb=label2rgb(fe);

%% Mesures
mes=regionprops(fe,'EquivDiameter');
d=[mes.EquivDiameter];
% Conversion
d=d/size(f,1)*hauteur_image;
% Histogramme
h=hist(d,1:ceil(max(d)));
h=h(classes);
%h=hist(d,classes);
end


