function imt=mosaic_affine(im,T,im2)

t=size(im);
v1=T*[1;1;1];
v2=T*[1;t(2);1];
v3=T*[t(1);1;1];
v4=T*[t(1);t(2);1];

mn=min([v1';v2';v3';v4']);
mx=max([v1';v2';v3';v4']);

t=size(im2);
nmx=max(t,mx);

imt=uint8(zeros(ceil(nmx(1)-mn(1)+1),ceil(nmx(2)-mn(2)+1),3));
for x=1:size(imt,1)
    for y=1:size(imt,2)
        xy=round(inv(T)*[x+mn(1);y+mn(2);1]);
        if (xy(1)>0 && xy(1)<size(im,1) && xy(2)>0 && xy(2)<size(im,2))
            imt(x,y,:)=im(xy(1),xy(2),:);
        elseif (round(x+mn(1))>0 && round(x+mn(1))<size(im2,1) && round(y+mn(2))>0 && round(y+mn(2))<size(im2,2))
            imt(x,y,:)=im2(round(x+mn(1)),round(y+mn(2)),:);
        end
    end
end
