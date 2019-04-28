function [ a, num_loop, n_res_first, n_res_second ] = correct_res( a, num_loop, n_res_first, n_res_second)
% CORRECT_RES removes all the small loops and reservoirs.
%   We eliminate loops and reservoirs below of a certain height.
%fprintf('n_res_second %d\n',n_res_second);
b = size(a);
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

%for reserovir
comp_height = find_comp_height(a);
min_height = floor(comp_height/12);

% for loop
min_loop_height = floor(comp_height / 12 ) ;
%

signi_res = zeros(1, num_res);
cnt = 1;

% for loop
for i= 2: num_loop
    if height(i) >= min_loop_height
        signi_res(i) = cnt;
    else
        cnt = cnt + 1;
    end
end

n_num_loop = num_loop+1 - cnt;


for i=( num_loop + 1) : n_res_first
    if height(i) >= min_height
        signi_res(i) = cnt;
    else
        cnt = cnt + 1;
    end
end

n_n_res_first = n_res_first + 1 - cnt;
%fprintf('n_res_first %d\n',n_res_first);
%fprintf('cnt %d\n',cnt);

for i=( n_res_first + 1) : num_res
    if height(i) >= min_height
        signi_res(i) = cnt;
    else
        cnt = cnt + 1;
    end
end
%fprintf('cnt %d\n',cnt);
n_res_second = num_res+1 - cnt;
num_loop = n_num_loop;
n_res_first = n_n_res_first;
%fprintf('num_loop %d, n_res_first %d, n_res_second %d\n',num_loop,n_res_first,n_res_second);
for i=1:b(1)
    for j=1:b(2)
        if a(i,j) > 1
            if signi_res(a(i,j)) == 0
                a(i,j) = 1;
            else
                a(i,j) = (a(i,j)+1)- signi_res(a(i,j));
            end
        end
    end
end


end