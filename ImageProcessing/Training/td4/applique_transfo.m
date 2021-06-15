function imt=applique_transfo(im,T,taille)

imt=uint8(zeros(taille));
for x=1:taille(1)
    for y=1:taille(2)
        xy=round(inv(T)*[x;y;1]);
        if (xy(1)>0 && xy(1)<size(im,1) && xy(2)>0 && xy(2)<size(im,2))
            imt(x,y,:)=im(xy(1),xy(2),:);
        end
    end
end
