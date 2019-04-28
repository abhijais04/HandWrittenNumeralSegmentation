function [ val ] = is_connected( a, num_loop, n_res_second )
%IS_CONNECTED Summary of this function goes here
%   Detailed explanation goes here
% a is the image to be processed
% num_loop is the max number of loops in the image
% n_res_second is the total number of loops and reservoirs in the image

n_res = n_res_second - num_loop;
T = n_res_second - 1; % total of loops and reservoirs

X = zeros(1,n_res_second);
Y = zeros(1,n_res_second);
num_pix = zeros(1,n_res_second);
b = size(a);

for i=1:b(1)
    for j=1:b(2)
        if a(i,j) >= 1
            X(a(i,j)) = X(a(i,j)) + i;
            Y(a(i,j)) = Y(a(i,j)) + i;
            num_pix(a(i,j)) = num_pix(a(i,j)) + 1;
        end
    end
end

CGX = zeros(1,n_res_second);
CGY = zeros(1,n_res_second);
for i=1:n_res_second
    CGX(i) = X(i) / num_pix(i);
    CGY(i) = Y(i) / num_pix(i);
end


c_up = zeros(1,n_res_second);
c_down = zeros(1,n_res_second);
for i=1:n_res_second
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

height = zeros(1, n_res_second);
%height is an array which stores the height of every loop and reservoir
for i=1:n_res_second
    height(i) = c_down(i) - c_up(i);
    %fprintf('height of %d is %d\n',i,height(i));
end

%comp_height = find_comp_height(a);
% this is height of the component

S_A = func1(num_loop, CGX,CGY);
S_B = func2(height, CGY, a, num_loop,n_res_second);
S_C = 0;
%fprintf('n_res is %d\n',n_res_second);
if n_res_second > 4
    %fprintf('in S_C\n');
    S_C = 1;
end

%('T %d\n',T);
if S_A == 1
    val = 1;
else
    if S_C == 1
        val = 1;
    else
        if S_B == 1 && T >= 3
            %fprintf('is here\n');
            val = 1;
        else
            if S_B == 1 && T < 3
                %fprintf('is here\n');
                val = 3;
            else
                if S_B == 0 && T <= 3
                    %fprintf('is here\n');
                    val = 3;
                else
                    %fprintf('is here\n');
                    val = 0;
                end
            end
        end
    end
end
%fprintf('%d %d %d %d\n',val,S_B,n_res_second,num_loop);
if val == 3 && T>0
    %fprintf('is here\n');
    val = connect_modified(a, num_loop, n_res_second, height, CGY);
end

end

