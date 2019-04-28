function [ S_A ] = func1( num_loop, CGX, CGY )
%FUNC1 Summary of this function goes here
%   Detailed explanation goes here

S_A = 0;

if num_loop>=3
    for i=1:num_loop
        for j=i+1:num_loop
            if ((abs(CGX(i)-CGX(j))) >= (abs(CGY(i)-CGY(j))))
                S_A = 1;
            end
        end
    end
end

end

