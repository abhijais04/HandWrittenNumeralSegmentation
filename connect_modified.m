function [ val ] = connect_modified( a, n_l, n_res, height, CGY )
%CONNECT_MODIFIED Summary of this function goes here
%   Detailed explanation goes here
%fprintf('compenent is here\n');
val = 0;
[comp_height,d,u,w,l,r] = find_comp_height_new(a); % w,l,r are of no use
%fprintf('comp_height is %d\n',comp_height);
d_new = d - (floor(comp_height/4));
u_new = u + (floor(comp_height/4));
height_break_2 = floor((1*comp_height)/3);
height_break_1 = floor((3*comp_height)/5);
%fprintf('d_new %d\nu_new %d\nCGY(2) %d\nCGY(3) %d\n',d_new,u_new,CGY(2),CGY(3));
if(n_l == n_res)
    val = 0;
else
    if(n_res <= 2)
        val = 0;
    else
        if(n_l + 1 == n_res)
           %fprintf('n_res %d\n',n_res);
           val = 0;
        else
            for i=n_l+1 : n_res
                if height(i) >= height_break_2
                    %fprintf('is here\n');
                    val = 1;
                    %if n_res>=3 
                    %    break;
                    %end
                else
                    %fprintf('is here\n');
                    val = 0;
                end
            end
        end
    end
end

if func2(height, CGY, a, n_l,n_res) == 1
    if n_res>=3
       val=1;
    end
end

end

