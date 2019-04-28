function [ num ] = find_num_loop( a )
%FIND_NUM_LOOP provides number of loops in provided "bwlabeled" image
%   It accepts the image and find the max number in it and that number is
%   one greater than the number of loops in that image

b = size(a); % size of the labeled image
mx = 0; %maximum value of any pixel in the image
for i=1:b(1)
    for j=1:b(2)
        if mx < a(i,j)
            mx = a(i,j);
        end
    end
end
num = mx; % number of loops + 1
end

