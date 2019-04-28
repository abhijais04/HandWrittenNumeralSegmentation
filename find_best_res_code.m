function [ max_area_code, best_loop_X, best_loop_Y ] = find_best_res_code( a,num_loop,n_res_second )
%FIND_BEST_RES_CODE gives the code for the best reservoir
%   Detailed explanation: finds the res with CG in middle and largest area
%   This is good explanation of the function, try to explain other
%   functions like this one.

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
    CGX(i) = floor(CGX(i)/arr(i));
    CGY(i) = floor(CGY(i)/arr(i));
    % fprintf('arr(%d) %d\n',i,arr(i));
    % fprintf('CGX %d CGY %d\n',CGX(i),CGY(i));
end

[comp_height, d, u, comp_width, l, r] = find_comp_height_new(a);
% comp_height = d-u
h_top = u + floor(comp_height/4);
h_bottom = d - floor(comp_height/4);

w_left = l + floor( comp_width/4);
w_right = r - floor( comp_width/4);

area=0;max_area_code = 0;
% fprintf('num_loop %d\n',num_loop);
% fprintf('h_top %d h_bottom %d\n',h_top,h_bottom);
for i=num_loop+1 : n_res_second
    %fprintf('%d %d %d\n',CGY(i), w_left, w_right);
    if CGY(i)>=w_left && CGY(i) <=w_right
        %fprintf('is here\n');
        if area < arr(i)
            max_area_code = i;
            area = arr(i);
        end
    end
end
%fprintf('max_area_code %d\n',max_area_code);

loop_area=0;loop_area_code = 0;
for i=2:num_loop
    if loop_area < arr(i)
        loop_area_code = i;
        loop_area = arr(i);
    end
end

best_loop_X = 0;
best_loop_Y = 0;
if loop_area_code ~= 0
    best_loop_X = CGX(loop_area_code);
    best_loop_Y = CGY(loop_area_code);
end


end