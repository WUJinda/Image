function [ Ith ] = tse_bwthinning( I, nb )
%tse_bwthinning Performs morphological thinning of I by applying hit or miss
%   transform on a set of structuring element pairs.
%
%   I: source image
%   nb: number of iterations
%   Ith: return thinned image

% Structuring elements
B{1} =      [   -1 -1 -1   ;...
                 0  1  0   ;...
                 1  1  1   ];

B{2} =      [    0 -1 -1   ;...
                 1  1 -1   ;...
                 0  1  0   ];

B{3} =      [    1  0 -1   ;...
                 1  1 -1   ;...
                 1  0 -1   ];

B{4} =      [    0  1  0   ;...
                 1  1 -1   ;...
                 0 -1 -1   ];

B{5} =      [    1  1  1   ;...
                 0  1  0   ;...
                -1 -1 -1   ];

B{6} =      [    0  1  0   ;...
                -1  1  1   ;...
                -1 -1  0   ];

B{7} =      [   -1  0  1   ;...
                -1  1  1   ;...
                -1  0  1   ];

B{8} =      [   -1 -1  0   ;...
                -1  1  1   ;...
                 0  1  0   ];

Icur=I>0;
Ith=Icur;
stop=false;
k=1;
while k<=nb && ~stop
   for i=1:8
      Icur=Icur - bwhitmiss(Icur,B{i}); 
   end
   if any(Icur(:)~=Ith(:)) % if any element modified
       k=k+1;
       Ith=Icur;
%        imshow(Ith)
%        pause
   else                    % Nothing chanded
       stop=true;
   end
end
Ith=Ith>0;

