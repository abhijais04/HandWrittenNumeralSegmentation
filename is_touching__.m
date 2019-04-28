function [ res, im_new ] = is_touching__(a,k1,k2, original_image, folderAddr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%{
 tp1 = top_point(a, k1);
bp1 = bottom_point(a,k1);
tp2 = top_point(a, k2);
tp3 = bottom_point(a, k2);
res=0;
tp = max(tp1,tp2);
bp = min(tp1,tp2);
cy = 0;
%}
im_new=0;
res=0;
b = size(a);
% fprintf('Checking for values - %d %d\n', k1,k2);
    
    % fprintf('Checking for values again - %d %d \n', k1,k2);
    for i=1:b(1)
        [res1,fbp,lbp] = check_connectivity_in_horizontal_line(a,i,k1,k2);
        
        if res1==1
            im_new = segment_loop__(a,i,fbp,lbp, original_image, folderAddr );
            res=1;
            break;
        end
    end

end

