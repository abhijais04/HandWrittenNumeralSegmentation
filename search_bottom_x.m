function [ bottom_x ] = search_bottom_x( a, x, y, res_code )
%SEARCH_BOTTOM_X Summary of this function goes here
%   Detailed explanation goes here
%fprintf('rough a(%d %d) is %d\n',x,y,a(x,y));
b = size(a);
if a(x,y)==0
    while a(x,y)==0
        x = x + 1;
    end
    bottom_x = x - 1;
else
    if a(x,y)==res_code
        while a(x,y)==res_code
            x = x - 1;
        end
        bottom_x = x;
    else
        % if pixel is not black and not a part of reservoir
        %fprintf('a(%d,%d) %d\n',x,y,a(x,y));
        %fprintf('res_code %d\n',res_code);
        while a(x,y) ~= 0
            x = x - 1;
            if x==0
                break;
            end %%%% changed here
        end
        bottom_x = x;
    end
end

end

