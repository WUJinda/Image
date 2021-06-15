function h=distribution_taille(f,hauteur_image,classes)
% Calcul de la distribution de taille d'objets dans une image
% Retourne un histogramme
% Parametres :
%   f = image a analyser
%   hauteur_image = hauteur de l'image en mm
%   classes = tableau donnant les limites de classes pour l'histogramme
% Fonction appellee dans td1


h=hist(1:10,classes);  % histogramme test a remplacer par le vrai calcul


end


