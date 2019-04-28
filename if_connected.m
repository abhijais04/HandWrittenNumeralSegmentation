function [ result_image ] = if_connected( im_res,num_loop,n_res_first,n_res_second,original_image,folderAddr )
%IF_CONNECTED to seperate the connections we need to move here.
%   Detailed explanation: it follows the research paper.

b=size(im_res);
%imtool(im_res);
% now we need to find the best reservoir
[ best_res_code, best_loop_X, best_loop_Y ] = find_best_res_code(im_res,num_loop,n_res_second);
%fprintf('best_res_code %d\n',best_res_code);
%[x , y1, y2] = detect_base_line(im_res, best_res_code,n_res_first);
% base-line is from x,y1 to x,y2

% now we need to collect all the boundary points of the best reservoir
% then we need to find Ip of it.
[x_ip,y_ip] = find_ip(im_res,best_res_code, n_res_first);

%now we will decide touching position on the base of the value of x_ip
[comp_height, d, u, comp_width, l, r] = find_comp_height_new(im_res);
% comp_height = d-u
h_top = u + floor(comp_height/4);
h_bottom = d - floor(comp_height/4);

w_left = l + ceil(comp_width/4);
w_right = r - ceil(comp_width/4);

%fprintf('x_ip %d\n',x_ip);
%x_top=0;x_bottom=0;
if x_ip < h_top
    % touching position is top
    x_top = 1;
    x_bottom = h_top;
else
    if x_ip > h_bottom
        % touching position is bottom
        x_top = h_bottom;
        x_bottom = b(1);
    else
        %touching position is middle
        x_top = h_top;
        x_bottom = h_bottom;
    end
end
% this provides the limits to consider the base line of any reservoir

feature_point_x = zeros(2*n_res_second);
feature_point_y = feature_point_x;

feature_point_res = feature_point_x; % new line
% to store that which feature point belongs to which reservoir
feature_point_run_length = feature_point_x; % new line
% to store the run_length of every feature point
feature_point_count = 0;

%
% We need to calculate Confidence value too...for this we find the CG of
% component and later we'll use it to find euclidean distance of each
% feature point. Also we need to find height of each reservoir and CG of
% each loop.
%

%find CG of component
[CG_comp_x, CG_comp_y] = find_comp_CG(im_res);
%fprintf('CG_comp %d %d\n',CG_comp_x, CG_comp_y);
feature_point_comp_distance = feature_point_x;
feature_point_res_height = feature_point_x;

[res_height, CGX, CGY] = find_res_height_CG(im_res);

% loop testing

% the next part from sem 7 is to be start here
% part 1: components having two side by side touching close loops
[ boolval, result_image ] = are_loops_touching( im_res, CGX, CGY, num_loop, original_image, folderAddr );

if boolval == 1
    return
end
%fprintf('\nboolval %d\n',boolval);


% now we need to check each reservoir
%fprintf('x_top %d x_bottom %d\n',x_top,x_bottom);
for i=num_loop+1 : n_res_second
    [x , y1, y2] = detect_base_line(im_res, i, n_res_first);
    %fprintf('is here\n');
    if x>=x_top && x<=x_bottom
        %fprintf('is here\n');
        L = y2 - y1;
        R = find_run_length(im_res, i);
        %fprintf('L %d R %d\n',L,R);
        if L < (2*R)
            % only one feature point will be added
            feature_point_count = feature_point_count + 1;
            feature_point_res(feature_point_count) = i;
            feature_point_run_length(feature_point_count) = R;
            feature_point_x(feature_point_count) = x;
            feature_point_y(feature_point_count) = floor((y1+y2)/2);
            feature_point_comp_distance(feature_point_count) = find_euclidean_distance(x,floor((y1+y2)/2),CG_comp_x, CG_comp_y);
            %fprintf('feature_point_comp_distance(feature_point_count) %d\n',find_euclidean_distance(x,floor((y1+y2)/2),CG_comp_x, CG_comp_y));
            feature_point_res_height(feature_point_count) = res_height(i);
        else
            % two feature points will be added
            feature_point_count = feature_point_count + 1;
            feature_point_res(feature_point_count) = i;
            feature_point_run_length(feature_point_count) = R;
            feature_point_x(feature_point_count) = x;
            feature_point_y(feature_point_count) = y1;
            feature_point_comp_distance(feature_point_count) = find_euclidean_distance(x,y1,CG_comp_x, CG_comp_y);
            feature_point_res_height(feature_point_count) = res_height(i);
            feature_point_count = feature_point_count + 1;
            feature_point_res(feature_point_count) = i;
            feature_point_run_length(feature_point_count) = R;
            feature_point_x(feature_point_count) = x;
            feature_point_y(feature_point_count) = y2;
            feature_point_comp_distance(feature_point_count) = find_euclidean_distance(x,y2,CG_comp_x, CG_comp_y);
            feature_point_res_height(feature_point_count) = res_height(i);
        end
    end
end
%fprintf('total feature point %d\n',feature_point_count);
feature_point_loop_distance = zeros(2*n_res_second, num_loop);
for i=1:feature_point_count
    for j=1:num_loop
        feature_point_loop_distance(i,j) = find_euclidean_distance(feature_point_x(i),feature_point_y(i),CGX(j),CGY(j));
    end
end

% now we need to find confidence value
CV = zeros(feature_point_count);


CV_1 = find_CV_1(feature_point_comp_distance,feature_point_count);
CV_2 = find_CV_2(feature_point_comp_distance,feature_point_loop_distance,feature_point_count, num_loop);
CV_3 = find_CV_3(feature_point_res_height, feature_point_count);

CV_code=0; max_CV = 0; %index of best feature point.

for i=1:feature_point_count
    CV(i) = CV_1(i) + CV_2(i) + CV_3(i);
    %fprintf('CV %d CV_1 %d CV_2 %d CV_3 %d\n',CV(i),CV_1(i),CV_2(i),CV_3(i));
    if max_CV < CV(i)
        %fprintf('is here\n');
        
        % CV_code is the index of our best feature point
        % by this we will have all the data about best feature point which
        % is gonna be used later for the final segmentation.
        CV_code = i;
        max_CV = CV(i);
    end
end

n_m=im_res;
for x=1:feature_point_count
    %x = CV_code;
    i = feature_point_x(x);
    j = feature_point_y(x);
    %fprintf('feature point %d %d\n', i,j);
    n_m = highlight_point(n_m,i,j);
end
result_image = n_m;
%fprintf('total feature point %d\n',feature_point_count);
%imtool(result_image);
result_image = print_image(original_image, result_image, folderAddr, 'featurePoints.png' );

n_m = im_res;
% going for best feature point
x = CV_code;
i = feature_point_x(x);
j = feature_point_y(x);
%fprintf('best feature point at %d %d\n', i,j);
result_image = highlight_point(n_m, i,j);
result_image = print_image(original_image, result_image, folderAddr, 'bestFeature.png');
% print_image is not changing anything in result_image



% we will make a check late about the part,
% right now we are jumping to second part
% part = 2;
% we created feature_point_res to store the reservoir to which the feature
% point belongs.
x = feature_point_x(CV_code);
y = feature_point_y(CV_code);
run_length = feature_point_run_length(CV_code);
res_code = feature_point_res(CV_code);
[ left_x, left_y, right_x, right_y ] = find_node_points( im_res, x, y, run_length, res_code);
%fprintf('left node point at %d %d\n', left_x,left_y);
%fprintf('right node point at %d %d\n', right_x,right_y);
result_image = im_res;
result_image = highlight_point( result_image, left_x, left_y );
result_image = highlight_point( result_image, right_x, right_y);
result_image = print_image( original_image, result_image, folderAddr, 'nodePoints.png' );

% we are good till here.
% getting right node points.

% Now we use node points to segment the component.
% For this we use the vertical location of the node points.

%fprintf('h_top %d h_bottom %d\n',h_top,h_bottom);
%fprintf('w_left %d w_right %d\n',w_left,w_right);


if res_code <= n_res_first
    is_top = 1;
else
    is_top = 0;
end


% in trial
n_t = 0; % new_token
%%{
if left_x == 0
    best_y = right_y;
    best_x = right_x;
    n_t = 2;
end
if right_x == 0
    best_y = left_y;
    best_x = left_x;
    n_t = 2;
end

if n_t == 2
    if best_x == 0
        best_x = x;
        best_y = y;
    end
end
%%}

if n_t == 0
    if x < h_top
        if left_x > h_top && right_x < h_top
            best_y = right_y;
            best_x = right_x;
            n_t = 1;
        else
            if right_x > h_top && left_x < h_top
                best_y = left_y;
                best_x = left_x;
                n_t = 1;
            else
                if right_x > h_top && left_x > h_top
                    best_y = y;
                    best_x = x;
                    n_t = 1;
                end
            end
        end
    else
        if x > h_bottom
            if left_x < h_bottom && right_x > h_bottom
                best_y = right_y;
                best_x = right_x;
                n_t = 1;
            else
                if right_x < h_bottom && left_x > h_bottom
                    best_y = left_y;
                    best_x = left_x;
                    n_t = 1;
                else
                    if right_x < h_bottom && left_x < h_bottom
                        best_y = y;
                        best_x = x;
                        n_t = 1;
                    end
                end
            end
        end
    end
end

if n_t ~= 0 
    %fprintf('best_cutting point at %d %d\n', best_x,best_y);
    result_image = highlight_point( im_res, best_x, best_y);
    result_image = print_image(original_image, result_image, folderAddr, 'cuttingPoint.png');
    %cut vertically
    %fprintf('is here 1\n');
    result_image = cut_vertical( im_res, best_x, best_y, is_top );
    %imtool(result_image);
end

%till here


if n_t == 0
    if ( left_x<=h_top && right_x <= h_top ) || ( left_x>=h_bottom && right_x >= h_bottom )
        if ( left_y <= w_left && right_y >= w_right ) || ( left_y >= w_left && right_y <= w_right )
            %fprintf('is here 4\n');
            best_y = floor( (left_y + right_y)/2 );
            best_x = floor( (left_x + right_x)/2 );
        else
            if right_y > w_right
                %fprintf('is here 5\n');
                best_y = left_y;
                best_x = left_x;
            else
                best_y =  right_y;
                best_x =  right_x;
            end
        end
        if res_code <= n_res_first
            %is_top == 1
            %fprintf('is here\n');
            best_x = search_top_x( im_res, best_x, best_y, res_code );
        else
            %is_top == 0
            best_x = search_bottom_x( im_res, best_x, best_y, res_code );
        end
        %fprintf('best_cutting point at %d %d\n', best_x,best_y);
        result_image = highlight_point( im_res, best_x, best_y);
        result_image = print_image(original_image, result_image, folderAddr, 'cuttingPoint.png');
        %cut vertically
        %fprintf('is here 2\n');
        result_image = cut_vertical( im_res, best_x, best_y, is_top );
        %imtool(result_image);
    else
        best_x = 0; best_y=0;
        if ( left_x < h_top || left_x > h_bottom )
            % right point is in midddle
            best_x = right_x; best_y = right_y;
        else
            if ( right_x < h_top || right_x > h_bottom )
                % left point is in middle
                best_x = left_x; best_y = left_y;
            else
                % both points are in middle
                if best_loop_X ~= 0
                    % at least one loop
                    %fprintf('loop_x %d, loop_y %d\n',best_loop_X,best_loop_Y);
                    dis_left = find_euclidean_distance(left_x,left_y,best_loop_X, best_loop_Y );
                    dis_right = find_euclidean_distance(right_x,right_y,best_loop_X, best_loop_Y);

                    if dis_left < dis_right
                        best_x = left_x; best_y = left_y;
                    else
                        best_x = right_x; best_y = right_y;
                    end

                else
                    % no loop found
                    % find middle of the component
                    mid_Y = floor( ( l + r )/2 );
                    mid_X = floor( ( d + u )/2 );

                    dis_left = find_euclidean_distance(left_x,left_y,mid_X,mid_Y );
                    dis_right = find_euclidean_distance(right_x,right_y,mid_X,mid_Y);

                    if dis_left < dis_right
                        best_x = left_x; best_y = left_y;
                    else
                        best_x = right_x; best_y = right_y;
                    end

                end
            end
        end
        %fprintf('best_cutting point at %d %d\n', best_x,best_y);
        result_image = highlight_point( im_res, best_x, best_y);
        result_image = print_image(original_image, result_image, folderAddr, 'cuttingPoint.png');
        % cut vertical
        %fprintf('is here 3\n');
        result_image = cut_vertical( im_res, best_x, best_y, is_top );
        %imtool(result_image);
    end
end

end

