function [ a ] = find_CV_3( b, c )
%FIND_CV_3 Summary of this function goes here
%   Detailed explanation goes here

% b = feature_point_res_height, c = feature_point_count

a = zeros(c);

sum = 0;
for i=1:c
    sum = sum + b(i);
end

for i=1:c
    a(i) = b(i)/sum;
end

end

