function [ n_m ] = highlight_point( n_m, i, j )
%HIGHLIGHT_POINT Summary of this function goes here
%   Detailed explanation goes here

if i==0 || j==0
    return;
end

n_m(i,j)=100;
n_m(i-1,j-1)=100;
n_m(i-1,j)=100;
n_m(i-1,j+1)=100;
n_m(i,j-1)=100;
n_m(i,j+1)=100;
n_m(i+1,j-1)=100;
n_m(i+1,j)=100;
n_m(i+1,j+1)=100;

end

