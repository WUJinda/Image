function fs=tse_imnearestcenter(f,centers,labels)
%TSE_IMNEARESTCENTER Segments an image by setting the label of the nearest
% center in the space of pixels.
%
%
%  FS=TSE_IMNEARESTCENTER(F,CENTERS,LABELS) returns the image FS obtained after
%  segmentation of input image F centers given by CENTERS using the given
%  by LABELS (by default consecutive labels)
%

if nargin<3, labels=1:size(centers,1);end

[m,n,p]=size(f);

% assign each pixel of f to the closest center
fs=zeros(m,n,'uint8');
pt=zeros(1,p);
for i=1:m
    for j=1:n
        pt(1,:)=f( i,j, :) ;
        min_diff = (pt- centers( 1,:) );
        min_diff = min_diff * min_diff';
        curAssignment = 1;
        for c = 2 : size(centers,1)
          diff2c = ( pt - centers( c,:) );
          diff2c = diff2c * diff2c';
          if( min_diff >= diff2c)
            curAssignment = c;
            min_diff = diff2c;
          end
        end
        fs(i,j)=uint8 (labels(curAssignment));
    end
end
end



