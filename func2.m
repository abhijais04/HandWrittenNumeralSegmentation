function [ S_B ] = func2( height, CGY, a, num_loop, n_res_second )
%FUNC2 Summary of this function goes here
%   Detailed explanation goes here

S_B = 0;

[comp_height,d,u] = find_comp_height_new(a);
d_new = d - (floor(comp_height/4));
u_new = u + (floor(comp_height/4));
height_break = floor((3*comp_height)/5);

for i=2 : n_res_second
    if height(i) >= height_break
        S_B = 1;
        %if CGY(i) > u_new && CGY(i) < d_new
        %    S_B = 1;
        %end
    end
end


end

