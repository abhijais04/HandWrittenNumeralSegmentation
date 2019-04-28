function [ CG_comp_x, CG_comp_y ] = find_comp_CG( im_res )
%FIND_COMP_CG Summary of this function goes here
%   Detailed explanation goes here
%im_res_CG = im_res;
%imtool(im_res_CG);
CG_comp_x = 0; CG_comp_y = 0; sum_pix=0;

b = size(im_res);
for i=1:b(1)
    for j=2:b(2)
        %fprintf('is here\n')
        if im_res(i,j)==0
            %fprintf('is here\n');
            CG_comp_x = CG_comp_x + i;
            CG_comp_y = CG_comp_y + j;
            sum_pix = sum_pix + 1;
        end
    end
end
%fprintf('CG %d %d\n',CG_comp_x, CG_comp_y);
CG_comp_x = floor(CG_comp_x / sum_pix);
CG_comp_y = floor(CG_comp_y / sum_pix);
%fprintf('CG %d %d\n',CG_comp_x, CG_comp_y);
end

