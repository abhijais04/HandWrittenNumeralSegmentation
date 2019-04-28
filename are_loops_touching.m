function [ res, im_new ] = are_loops_touching( input_im, CGX,CGY, n_loop, original_image, folderAddr )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
a = input_im;
im_new=0;
%n_loop = bwlabel(rgb2gray(o_im), 4);
%imtool(input_im);
%fprintf('number of loops %d\n',n_loop);
n_loop = n_loop - 1;
temp = 0;
%{
for i = 1:n_loop
    for j = i+1:n_loop
        if ((abs(CGX(i)-CGX(j))) >= (abs(CGY(i)-CGY(j))))
            continue;
        end
        fprintf('%d %d loops\n', i,j);
        % First method 
        % temp = is_touching(input_im,i,j,CGX,CGY);
        %second method
        temp = is_touching__(input_im,i,j,CGX,CGY);
        if temp == 1
            segment_loop__(input_im,i,j,CGX,CGY);
            break;
        end
    end
    if j < n_loop + 1
        break;
    end
end
%}
for i = 2:n_loop
    for j = i+1:n_loop+1
        
        %fprintf('%d %d loops\n', i,j);
        % First method 
        % temp = is_touching(input_im,i,j,CGX,CGY);
        %second method
        x1 = CGX(i);
        y1 = CGY(i);
        x2 = CGX(j);
        y2 = CGY(j);
        %image = highlight_point();
        tanx = abs((x2 - x1 )/(y2 - y1 ));
        %fprintf('tanx %f\n',tanx);
        if tanx > 1
            continue;
        end
        [temp, im_new] = is_touching__(input_im,i,j, original_image, folderAddr );
        if temp==1
            break
        end
        
    end
    if temp==1
        break;
    end
end
res = temp;

if res == 1
    %fprintf('Loops connected\n');
else
    %fprintf('Loops Not connected\n');
end

end

