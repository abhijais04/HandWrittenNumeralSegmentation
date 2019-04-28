function [ a ] = noise_cleaner( a )
%NOISE_CLEANER Summary of this function goes here
%   Detailed explanation goes here

% a is a binary image
c = ~a;
b = size(a);

se = strel('disk', 1);
c = imdilate(c,se);
%imtool(c);

d = bwlabel(c);
e = find_num_loop(d);

salt = zeros(1,e);
for i=1:b(1)
    for j=1:b(2)
        if d(i,j)~=0
            salt( d(i,j) ) = salt( d(i,j) ) + 1;
        end
    end
end

salt_threshold = 300;
for i = 1:e
    if salt( i ) < salt_threshold
        salt( i ) = -1;
    end
end

for i = 1:b(1)
    for j = 1:b(2)
        if d(i,j) ~= 0
            if salt( d(i,j) ) < 0
                c(i,j) = 0;
            end
        end
    end
end

for i = 1:b(1)
    for j = 1:b(2)
        if c(i,j)==0
            a(i,j)=1;
        end
    end
end

end

