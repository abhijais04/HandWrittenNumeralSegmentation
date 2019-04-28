function [ a ] = find_CV_1( b , c )
%FIND_CV_1 Summary of this function goes here
%   Detailed explanation goes here

% b = feature_point_comp_distance, c = feature_point_count
%fprintf('c %d\n',c);
sum=0;
for i=1:c
    %fprintf('b(%d) %d\n',i,b(i));
    sum = sum + b(i);
end
%fprintf('sum distance %d\n',sum);
a = zeros(c);
for i=1:c
    a(i) = sum / b(i);
end

end

