function [ val ] = reservoir( fileAddr,folderName,fileName )
a = imread(fileAddr); % the image you need to process
a = padding(a);
b = size(a);
%imtool(a);
%im_size = size(a);
%a = imresize(a,0.3);
cp = a; %rgb copy of the image
%b = rgb2gray(a); %2D conversion of the object(image/matrix);
%b = padding(b);
%imtool(b);
%b = imresize(b,0.3);
%c = b>200; %thresholding ( converting image into binary object);

%CHANGING THE THRESHOLDING METHOD
c = zeros(b(1),b(2));
for i=1:b(1)
    for j=1:b(2)
        if a(i,j,1)<200
            c(i,j)=0;
        else
            c(i,j)=1;
        end
    end
end

%%%% NOISE REMOVAL %%%%
c = noise_cleaner(c);
%se = strel('disk',1);
%c = imdilate(c,se);
%imtool(c);
%imwrite(c,sprintf('G:/sem 8/%s/dilatedImage/%s',folderName,fileName));
%c = ~c;
%c = padding(c);
%imtool(c);
d = bwlabel(c,4); % finding all the loops in the image
c = filter_small_loop(d,c);
d = bwlabel(c,4);
%imtool(d);
%imtool(c); %just to show the binary image

num_loop = find_num_loop(d); % finding number of initial loops in the image

n_res_beg = num_loop; % initial value to find total reservoirs
im_size = size(d); % size of the 2D matrix

%finding reservoirs

% finding top rerservoirs first
[im_res_top , n_res_first] = find_reservoir (c,d,im_size,num_loop);

%finding bottom reservoirs
c_bottom = rot90(c,2); d=rot90(d,2);
[im_res_bottom, n_res_second] = find_reservoir(c_bottom,d,im_size,num_loop);
d=rot90(d,2);
im_res_bottom = rot90(im_res_bottom , 2);

%imtool(im_res_top); imtool(im_res_bottom);
%fprintf('%d %d %d\n',num_loop,n_res_first,n_res_second);
[im_res, n_res_first, n_res_second] = merge_reservoir(c, im_res_top, n_res_first, im_res_bottom, n_res_second);
%fprintf('%d %d %d\n',num_loop,n_res_first,n_res_second);
%now we have finallly merged objects.
%imtool(im_res);

%fprintf('%d %d %d\n',num_loop,n_res_first,n_res_second);

% now we need to remove the small reservoirs and small loops
[im_res, num_loop, n_res_first, n_res_second] = correct_res(im_res, num_loop, n_res_first,n_res_second);
%fprintf('n_res_second %d\n',n_res_second);
%imtool(im_res);
%fprintf('num_loop %d n_res_f %d n_res_s %d\n',num_loop,n_res_first,n_res_second);
%imtool(im_res);
% finding if components are connected or not
val = is_connected(im_res, num_loop, n_res_second);

if val == 1
    %fprintf('compenent is connected\n');
    imwrite(a, fullfile('G:\sem 8', folderName, 'connect', fileName));
else
    if val == 0
        %fprintf('component is isolated \n');
        %imtool(im_res);
        imwrite(a, fullfile('G:\sem 8', folderName, 'isolated', fileName));
    else
        %fprintf('machine is not able to detect\n');
        imwrite(a, fullfile('G:\sem 8', folderName, 'confused', fileName));
    end
end
% if component is isolated then we need to stop here.
% if machine is confused then we need to stop.
% if componenet is connected then we need to proceed further.


if val == 1
    original_image = a;
    
    
    % create a folder for the image which is connnected
    % G:\semm 8\%s\connected\Image%s, folderName, fileName(4:end-4)
    fileFolder = strcat( 'Image', fileName(4:end-4) );
    mkdir( fullfile( 'G:\sem 8', folderName, 'connect', fileFolder));
    folderAddr = fullfile( 'G:\sem 8', folderName, 'connect', fileFolder );
    
    %imtool(im_res);
    imwrite(cp,fullfile(folderAddr, 'originalImage.png' ));
    im_res_1 = if_connected(im_res,num_loop,n_res_first,n_res_second,original_image, folderAddr );
    imwrite(im_res_1,fullfile(folderAddr, 'segmentedImage.png' ));
    %imtool0(im_res_1);
    %separate( im_res_1 );
end
end
