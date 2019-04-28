function [ left_x, left_y, right_x, right_y ] = find_node_points( a, x, y, R, res_code )
%FIND_NODE_POINTS to find the two node points from the best feature point.
%   Detailed explanation: Check if the reservoir is up or down.
% as the feature_points always come from the most top or most bottom line
% of any reservoir and this case occurs only when component is not edge
% connected, we can presume that we can easily traverse to both its left
% and right position. ( one of them at least ).

% now when we know that we can traverse on at least one of both the sides,
% we need to check on both side at the same time and when we reach at R>3/2
% for once on any side, we'll go for the second side.
% 
%       This don't look so necessary to me, but just a theory to be
%       improvise if we may happen to stuck at some point.
% 
%       Addition on 6th May 2018: this was a necessary condition and we
%       need to check it as soon as possible.
% 

% R : run-length
% a : b/w image with numbered loops and reservoirs.
% b : size of a
b = size(a);
% x,y : loaction of best_feature_point

% best_feature_point is always inside the reservoir
% it is another boundary point.

% check if it is top or bottom reservoir.
is_top = 0;
if a(x+1,y)==0
   is_top = 1; 
end
%fprintf('is_top %d\n',is_top);
%fprintf('run_length %d\n',R);
%fprintf('CV_x %d CV_y %d\n',x,y);
left_x=0;left_y=0;right_x=0;right_y=0;
%fprintf('xi is %d yi is %d\n',x,y);
if is_top==1
    top_x = x;
    last_top_x = x;
    % go for left
    for j=y-1:-1:1
        i=top_x;
        while a(i,j)==0
            i = i + 1;
        end
        bottom_x = i - 1;
        new_run = bottom_x + 1 - top_x;
        
        if (2*new_run) > (3*R )
            % we got the break point.
            left_y = j+1;
            left_x = last_top_x;
            break;
        else
            last_top_x = top_x;
            top_x = search_top_x(a, top_x, j-1, res_code );
            
            %%{
            if top_x == b(1)
                left_x = 0;
                left_y = 0;
                break;
            end
            %%}
        end
    end
    
    % go for right
    top_x = x;
    last_top_x = x;
    for j = y+1:b(2)
        i = top_x;
        while a(i,j)==0
            i = i + 1;
        end
        bottom_x = i - 1;
        new_run = bottom_x + 1 - top_x;
        
        if (2*new_run) > (3*R)
            right_y = j-1;
            right_x = last_top_x;
            break;
        else
            last_top_x = top_x;
            top_x = search_top_x(a, top_x, j+1, res_code);
            
            if top_x == b(1)
                right_x = 0;
                right_y = 0;
                break;
            end
        end
    end
    
else
    %for bottom reservoir
    bottom_x = x;
    last_bottom_x = x;
    % go for left
    for j=y-1:-1:1
        i=bottom_x;
        while a(i,j)==0
            i = i - 1;
        end
        top_x = i + 1;
        new_run = bottom_x + 1 - top_x;
        
        if (2*new_run) > (3*R )
            % we got the break point.
            left_y = j+1;
            left_x = last_bottom_x;
            break;
        else
            last_bottom_x = bottom_x;
            bottom_x = search_bottom_x(a, bottom_x, j-1, res_code );
            
            %%{
            if bottom_x == 0
                left_x = 0;
                left_y = 0;
                break;
            end
            %%}
        end
    end
    
    % go for right
    bottom_x = x;
    last_bottom_x = x;
    for j = y+1:b(2)-1
        i = bottom_x;
        while a(i,j)==0
            i = i - 1;
        end
        top_x = i + 1;
        new_run = bottom_x + 1 - top_x;
        
        if (2*new_run) > (3*R)
            right_y = j-1;
            right_x = last_bottom_x;
            break;
        else
            last_bottom_x = bottom_x;
            bottom_x = search_bottom_x(a, bottom_x, j+1, res_code);
            
            if bottom_x == 0
                right_x = 0;
                right_y = 0;
                break;
            end
        end
    end
end




end

