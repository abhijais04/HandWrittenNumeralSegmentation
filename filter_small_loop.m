function [ c ] = filter_small_loop( d,c )
%FILTER_SMALL_LOOP removes the small loops in the image
%   Detailed explanation goes here

b = size(d);
num_loop = find_num_loop(d);
e = zeros(num_loop);

for i=1:b(1)
    for j=1:b(2)
        if d(i,j) > 1
            e(d(i,j)) = e(d(i,j))+1;
        end
    end
end

for i=1:b(1)
    for j=1:b(2)
        if d(i,j)>1
            if e(d(i,j)) < 5
                c(i,j)=0;
            end
        end
    end
end


end

