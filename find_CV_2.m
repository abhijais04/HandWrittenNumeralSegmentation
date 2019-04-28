function [ a ] = find_CV_2( b,c,d,e )
%FIND_CV_2 Summary of this function goes here
%   Detailed explanation goes here

% b = feature_point_comp_distance, c = feature_point_loop_distance, d =
% feature_point_count, e = num_loop

a = zeros(d);

for i=1:d
    sum=0;
    for j=1:e
        sum = sum + c(i,j);
    end
    a(i) = sum/b(i);
end

end

