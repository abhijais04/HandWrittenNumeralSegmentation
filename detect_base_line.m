function [ x, y1, y2 ] = detect_base_line( im_res, best_res_code, n_res_first )
%DETECT_BASE_LINE Summary of this function goes here
%   Detailed explanation goes here

b = size(im_res);
x=0;y1=0;y2=0;
% detect base line of the reservoir
if best_res_code <= n_res_first
    % reservoir is top reservoir
    for i=1:b(1)
        for j=1:b(2)
            x = b(1)+1-i;
            y = j;
            if im_res(x-1,y)==best_res_code
                y1 = y;
                while im_res(x-1,y)==best_res_code
                    y = y + 1;
                end
                y2 = y-1;
                
            end
            if y1 > 0
                break;
            end
        end
        if y1 > 0
            break;
        end
    end
else
    % reservoir is bottom reservoir
    for i=1:b(1)
        for j=1:b(2)
            x = i;
            y = j;
            if im_res(x+1,y)==best_res_code
                y1 = y;
                while im_res(x+1,y)==best_res_code
                    y = y + 1;
                end
                y2 = y-1;
                
            end
            if y1 > 0
                break;
            end
        end
        if y1 > 0
            break;
        end
    end
    
end
% y2 > y1
end

