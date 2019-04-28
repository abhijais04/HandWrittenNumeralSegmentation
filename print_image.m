function [ im_res ] = print_image( new_cp, im_res, folderAddr, imageName )
%PRINT_IMAGE Summary of this function goes here
%   Detailed explanation goes here
im_size = size(im_res);
for i=1:im_size(1)
    for j=1:im_size(2)
        if im_res(i,j)==100
           new_cp(i,j,1)= 255;
           new_cp(i,j,2)=0;
           new_cp(i,j,3)=0;
           
        end
    end
end
%imtool(new_cp);
imwrite( new_cp, fullfile( folderAddr, imageName ));
end

