function [ height,d,u,width,l,r ] = find_comp_height_new( a )
%FIND_COMP_HEIGHT Summary of this function goes here
%   Detailed explanation goes here

% we will use 8 block mask to find neighbour pixel
b = size(a);
% we will use space for one pixel
% we want to find all parts specifically and different from each other
% also want to seperate them

%step 1 : find the boundry for whole image
l=b(2)+1;r=0;u=b(1)+1;d=0;
for i=1:b(1)
    for j=1:b(2)
        if a(i,j)==0
            % here our function goes for boundary
            if l>j
                l=j;
            end
            if r<j
                r=j;
            end
            if u>i
                u=i;
            end
            if d<i
                d=i;
            end
        end
    end
end

height = d-u;
width = r-l;
end

