function [ x_ip , y_ip ] = find_ip( im_res, best_res_code, n_res_first )
%FIND_IP Summary of this function goes here
%   Detailed explanation goes here

b = size(im_res);
y1=b(2);y2=1;
%fprintf('best res %d',best_res_code);
if best_res_code <= n_res_first 
    %fprintf('is here\n');
    %find xmax, ymin, ymax in top res
    x=0;
    for i=1:b(1)
        for j=1:b(2)
            if im_res(i,j)==0
                if im_res(i-1,j)==best_res_code
                    if x < i
                        x = i;
                    end
                end
                if im_res(i,j+1)==best_res_code
                    if y1 > j
                        y1 = j;
                    end
                end
                if im_res(i,j-1)==best_res_code
                    if y2 < j
                        y2 = j;
                    end
                end
            end
        end
    end
else
    %find xmin, ymin, ymax in bottom res
    x = b(1);
    for i=1:b(1)
        for j=1:b(2)
            if im_res(i,j)==0
                if im_res(i+1,j)==best_res_code
                    if x > i
                        x = i;
                    end
                end
                if im_res(i,j+1)==best_res_code
                    if y1 > j
                        y1 = j;
                    end
                end
                if im_res(i,j-1)==best_res_code
                    if y2 < j
                        y2 = j;
                    end
                end
            end
        end
    end
end


x_ip = x;
y_ip = floor((y1 + y2)/2);

end

