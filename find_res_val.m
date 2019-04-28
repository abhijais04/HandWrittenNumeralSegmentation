function [ val ] = find_res_val( c , d )
%FIND_RES_VAL gives the value provided to the new reservoir in the function
% "check_reservoir"
%   Detailed explanation: we check the first pixel which is part of a loop
%   in d but not in c thus it will have pixel value >1 but in c it'll have
%   pixel value 1.


b = size(c);
val = 0;
for i=1:b(1)
    for j=1:b(2)
        if c(i,j)==1 %when pixel value in c is 1
            if d(i,j) > 1 % but pixel value in d is not 1
                % when pixel is in loop in d but not in c
                val = d(i,j);
            end
        end
        if val>0
            break;
        end
    end
    if val>0
        break;
    end
end

end

