function [ res_height, CGX, CGY ] = find_res_height_CG( im_res )
%FIND_RES_HEIGHT_CG Summary of this function goes here
%   Detailed explanation goes here
a=im_res;
n_res_second = find_num_loop(im_res);
b = size(a);
arr = zeros(n_res_second);
CGX = arr;
CGY = arr;
for i=1:b(1)
    for j=1:b(2)
        if a(i,j)==0
            continue;
        end
        arr(a(i,j)) = arr(a(i,j)) + 1;
        CGX(a(i,j)) = CGX(a(i,j)) + i;
        CGY(a(i,j)) = CGY(a(i,j)) + j;
    end
end

for i=1:n_res_second
    CGX(i) = int32(CGX(i)/arr(i));
    CGY(i) = int32(CGY(i)/arr(i));
end

% uppper code is copied from find_best_res_code
% lower code(for height of reservoir) is copied from correct_res

num_res = n_res_second;
c_up = zeros(1,n_res_second);
c_down = zeros(1,n_res_second);
for i=1:num_res
    c_up(i) = b(1);
end
for i=1:b(1)
    for j=1:b(2)
        if a(i,j) > 0
            x = a(i,j);
            if c_up(x) > i
                c_up(x) = i;
            end
            if c_down(x) < i
                c_down(x) = i;
            end
        end
    end
end

height = zeros(1, num_res);
for i=2:num_res
    height(i) = c_down(i) - c_up(i);
end

res_height = height;


end

