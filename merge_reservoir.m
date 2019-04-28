function [ im_res, n_res_first, n_res_second ] = merge_reservoir( c, im_res_top, n_res_first, im_res_bottom, n_res_second )
%MERGE_RESERVOIR is a function to merge top and bottom reservoirs
%   Detailed explanation: it makes reservoirs top/bottomm on the base of
%   there domination in the original area.


% now we have both type of reservoirs, now we need to merge them.
% first we'll make red to all the reservoirs in a single image.
% we will colour those reservoirs red.
% then we will change them back to binary image.
% then we will make array for each of the new reservoirs.
% each of the two array will store its reservoir value for that reservoir.
% for example : if a reservoir in the red coloured pic has value 3 then the
%   value of arr1[3] will show the value of the top reservoir image for
%   that reservoir and '0' if there is no such reservoir in top reservoir.
%   The same will be done for the bottom reservoir.

b = size(c);
d = bwlabel(c,4);
num_loop = find_num_loop(d);
common_image = zeros(b(1),b(2));
%fprintf('%d %d %d\n',num_loop,n_res_first,n_res_second);
for i=2:b(1)
    for j=2:b(2)
        if im_res_top(i,j)>num_loop || im_res_bottom(i,j)>num_loop
            common_image(i,j) = 1;
        end
    end
end
%imtool(common_image); %right till here
c_label = bwlabel(common_image,4);
%imtool(c_label); %right till here
for i=1:b(1)
    for j=1:b(2)
        if c_label(i,j)>=1
            c_label(i,j) = c_label(i,j)+num_loop;
        end
    end
end

num_loop_label = find_num_loop(c_label);
arr_top = zeros(num_loop_label);
arr_bottom = zeros(num_loop_label);

%imtool(im_res_top); imtool(im_res_bottom);

for i=1:b(1)
    for j=1:b(2)
        if im_res_top(i,j)>num_loop
            if arr_top(c_label(i,j)) == 0
                arr_top(c_label(i,j)) = im_res_top(i,j);
            end
        end
        if im_res_bottom(i,j)>num_loop
            if arr_bottom(c_label(i,j)) == 0
                arr_bottom(c_label(i,j)) = im_res_bottom(i,j);
            end
        end
    end
end


% to compare any two reservoirs we need to find there area
area_top = zeros(n_res_first);
area_bottom = zeros(n_res_second);

for i=1:b(1)
    for j=1:b(2)
        if im_res_top(i,j) > 0
            area_top(im_res_top(i,j)) = area_top(im_res_top(i,j)) + 1;
        end
        if im_res_bottom(i,j) > 0
            area_bottom(im_res_bottom(i,j)) = area_bottom(im_res_bottom(i,j)) + 1;
        end
    end
end


result_compare = zeros(num_loop_label); % 1 will show top reservoir and 2 will show bottom one


% in this loop we will decide that which reservoir goes under which
% category
for i=num_loop+1:num_loop_label
    if arr_top(i)==0
        result_compare(i) = 2;
        continue;
    end
    if arr_bottom(i) == 0
        %fprintf(' i %d, area_bottom = 0\n',i);
        result_compare(i) = 1;
        continue;
    end
    if area_top(arr_top(i)) < area_bottom(arr_bottom(i))
        result_compare(i) = 2;
    else
        %fprintf('i %d area_top is large\n',i);
        result_compare(i) = 1;
    end
        
end
%fprintf('result compare %d %d\n',result_compare(2),result_compare(3));
% now we need to make them top and bottom reservoirs

%top reservoirs first
c_label_copy = c_label;
for i=1:b(1)
    for j=1:b(2)
        if c_label_copy(i,j) == 0
            continue;
        end
        if result_compare(c_label_copy(i,j))==2
            c_label_copy(i,j)=0;
        else
            c_label_copy(i,j) = 1;
        end
    end
end

c_label_copy = bwlabel(c_label_copy, 4);
num_res_top = find_num_loop(c_label_copy);


% paste the top reservoirs in the answer matrix
im_res = d;
for i=1:b(1)
    for j=1:b(2)
        if c_label_copy(i,j) >= 1
            im_res(i,j) = im_res(i,j) + c_label_copy(i,j) + num_loop -1;
        end
    end
end
n_res_first = num_loop + num_res_top;


%now bottom reservoirs
c_label_copy = c_label;
for i=1:b(1)
    for j=1:b(2)
        if c_label_copy(i,j) == 0
            continue;
        end
        if result_compare(c_label_copy(i,j))==1
            c_label_copy(i,j)=0;
        else
            c_label_copy(i,j) = 1;
        end
    end
end

c_label_copy = bwlabel(c_label_copy, 4);
num_res_bottom = find_num_loop(c_label_copy);

%paste the bottom reservoirs in the answer matrix
for i=1:b(1)
    for j=1:b(2)
        if c_label_copy(i,j) >= 1
            im_res(i,j) = im_res(i,j) + c_label_copy(i,j) + n_res_first -1;
        end
    end
end

n_res_second = n_res_first + num_res_bottom;

end