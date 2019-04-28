function [ mat1, n_l ] = find_reservoir( c, d, im_size, num_loop )
%FIND_RESERVOIR is about finding all reservoirs of one side of the image.
%   Detailed explanation goes here
% c is the image with thresholding
% d is the image with loops in it which will be change for all the time
% num_loop is number after which we will start the reservoir counters
% reservoir counter is using to number all the reservoirs
% this time we are just checking about the up-to-down size reservoirs
% W type reservoirs

% check_reservoir_new is a function to check if there is any reservoir
% reservoir in between (y,x1) to (y,x2)
% edit_matrix


n_l = num_loop;

for i=1:im_size(1) % i,y is counter for no. of row
    j=1;
    while j<=im_size(2) %j,x is counter for no. of col
        if d(i,j) == 0
            while d(i,j)==0 && j<im_size(2)
                j = j+1;
            end
            if j==im_size(2)
                break;
            else
                if d(i,j)==1
                    y = i;
                    x1 = j-1;
                    while d(i,j)==1 && j<im_size(2)
                        j = j+1;
                    end
                    if j==im_size(2)
                        break;
                    else
                        if d(i,j)==0
                            x2 = j;
                            [ val , mat ] = check_reservoir_new(c,y,x1,x2);
                            if val>0
                                n_l = n_l + 1;
                                d = edit_matrix(d,val,mat,n_l,x1,y,x2);
                                %imtool(d);
                            end
                        end
                    end
                else
                    j = j+1;
                end
            end
        else
            j = j+1;
        end
    end
end
mat1 = d;
end