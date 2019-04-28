function [ distance ] = find_euclidean_distance( x1,y1,x2,y2 )
%FIND_EUCLIDEAN_DISTANCE Summary of this function goes here
%   Detailed explanation goes here

distance = sqrt(((x2-x1)*(x2-x1)) +((y2-y1)*(y2-y1)));
%fprintf('is here\n');
end

