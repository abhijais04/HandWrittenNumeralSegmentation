function [ top_x ] = search_top_x( a, x, y, res_code )
%SEARCH_TOP_X Summary of this function goes here
%   Detailed explanation goes here
b = size(a);
if a(x,y)==0
    %fprintf('is here 2\n');
    while a(x,y)==0
        x = x - 1;
        
    end
    top_x = x + 1;
else
    if a(x,y)==res_code
        %fprintf('res_code %d here \n',res_code);
        %imtool(a);
        while a(x,y) == res_code
            x = x + 1;
        end
        top_x = x;
    else
        %fprintf('is here 3\n');
        %fprintf('x is %d y is %d\n',x,y);
        while a(x,y) ~= 0
            x = x + 1;
            if x == b(1)
                break;
            end %%%%% some editions that I've made here.
            %%%% I'll see them first after waking up.
        end
        top_x = x;
    end
end


end

