function [ a ] = traverse( a, x, y1, y2 )
%TRAVERSE to white from a( x, y1) to a(x,y2)
%   Detailed explanation goes here

% x is the new one

if y1 < y2
    ya = y1;
    yb = y2;
else
    ya = y2;
    yb = y1;
end

for y = ya:yb
    a(x,y) = 128;
end

end

