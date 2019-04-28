function [ res_value, c ] = check_reservoir_new( a, y, x1, x2 )
%CHECK_RESERVOIR_NEW is to check if there is any reservoir from (y,x1) to (y,x2)

% we will 

res_value = 0;
% pre_image = a;
im_size = size(a);
for i=1:y-1
    for j=1:im_size(2)
        a(i,j) = 1;
        % we are converting all the pixels above the line in white
    end
end
%imtool(a);
b = bwlabel(a,4);
for j=x1:x2
    a(y,j) = 0;
end
%imtool(a);
c = bwlabel(a,4);
n_l_b = find_num_loop(b);
n_l_c = find_num_loop(c);

if n_l_b < n_l_c
    %x = floor((x1+x2)/2);
    %res_value = c(y+1,x);
    res_value = find_res_val(b,c); % to find value provided to reservoir
end

end

