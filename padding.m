function [ c ] = padding( a )
%PADDING Summary of this function goes here
%   Detailed explanation goes here
pad = 10;
b = size(a);

c = zeros(b(1) + (2*pad), b(2) + (2*pad), 3, 'uint8' );
d = size(c);
for i=1:d(1)
    for j=1:d(2)
        for k=1:3
            c(i,j,k)=255;
        end
    end
end
%imtool(c);
c((pad+1):(b(1)+pad),(pad+1):(b(2)+pad),1:3) = a;
%a = c;

end