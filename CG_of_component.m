function [ output_args ] = CG_of_component( a, val )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

b = size(a);
x =0;
y =0;
for i=0:b(1)
    for j=0:b(2)
        if a(i,j)==val
            x = x + 
    end
end
end

