function [ a ] = cut_vertical( a, x, y, is_top )
%CUT_VERTICAL Summary of this function goes here
%   Detailed explanation goes here


%{
required:
is_top

%}
%fprintf('is top %d\n',is_top);
if is_top == 1
    p = +1; % to move pixel up / down
else
    p = -1;
end

cnt = 0;
if a(x,y) ~= 0
    x = x+p;
    cnt = cnt + 1;
end

xx = x;
yy = y;

% check if horizontal run legth is more than threshold or not
y1 = y;
%imtool(a);
%fprintf('x %d, y %d\n',x,y1);
while a(x,y1)==0
    %fprintf('x %d, y %d\n',x,y1);
    y1 = y1-1;
end
y1 = y1 + 1;

y2 = y;
while a(x, y2) == 0
    y2 = y2 + 1;
end
y2 = y2 - 1;

h_run = y2 + 1 - y1;
%fprintf('h run is %d\n',h_run);
if h_run < 15
    edge_cut = 1;
else
    edge_cut = 0;
end

if edge_cut == 1
    y = int32((y1 + y2)/2);
    while a(x,y) == 0
        x = x + p;
        cnt = cnt + 1;
    end
    
    %fprintf('cnt is %d\n',cnt);
    
    if cnt > 15
        % edge cut
        a = cut_edge(a,xx,yy, p);
        return;
    end
end

x = xx;
y = yy;
a(x,y)=1; a(x,y+1)=1; a(x,y-1)=1; %a(x,y+2)=1; a(x,y-2)=1;
i = x+1;
while a(i,y)==0
    a(i,y)=1; a(i,y+1)=1; a(i,y-1)=1; %a(i,y+2)=1; a(i,y-2)=1;
    i = i + 1;
end

i = x-1;
while a(i,y)==0
    a(i,y)=1; a(i,y+1)=1; a(i,y-1)=1; %a(i,y+2)=1; a(i,y-2)=1;
    i = i - 1;
end

end

