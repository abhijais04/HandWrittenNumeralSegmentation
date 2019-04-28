function [ a ] = cut_edge( a, x, y, p )
%CUT_EDGE Summary of this function goes here
%   Detailed explanation goes here

xx = x;
yy = y;

y1 = y;
while a(x,y1)==0
    y1 = y1-1;
end
y1 = y1 + 1;

y2 = y;
while a(x, y2) == 0
    y2 = y2 + 1;
end
y2 = y2 - 1;

y = ( y1 + y2 ) / 2;
y = int32(y);
x = int32(x);
b = size(a);

%%%%
xx = x;
yy = y;
    left = yy;
    right = yy;
    while a(xx,left)==0 && left > 0 
        left = left - 1;
    end
    while a(xx,right)==0 && right < b(2)
        right = right+1;
    end
    
  width = right - left + 1;


xx = x;
yy = y;

int32(xx);
int32(yy);



xxx=-1;
yyy=-1;

pyy = -1;

while a(xx,yy) == 0
    left = yy;
    right = yy;
    while a(xx,left)==0 && left > 0 
        left = left - 1;
    end
    while a(xx,right)==0 && right < b(2)
        right = right+1;
    end
    n_width = right - left + 1;
    if n_width > 1.5*width
        
        while a(xx,yy) == 0
            a(xx,yy) = 128;
            a(xx,yy+1)=128;
            % a(xx,yy+1)=128; a(xx,yy-1)=128;
            % fprintf('Segmenting 3---- %d %d\n', xx,yy);

            xx = xx + 1;
        end
        break;
    end
    
    yy = (left+right)/2;
    yy = int32(yy);
    a(xx,yy) = 128;% a(xx,yy+1)=128; a(xx,yy-1)=128
    a(xx,yy+1)=128;
    if pyy ~= -1
        a = traverse( a, xx, yy, pyy );
    end
    pyy = yy;
    
    if xxx==-1
            xxx=xx;
            yyy=yy;
     end
    
    % fprintf('Segmenting 4---- %d %d\n', xx,yy);

    xx = xx+p;
end


%cut vertically for 15 pixels 
cnt=0;
while cnt<13 && xxx>1
    a(xxx,yyy) = 128;
    a(xxx,yyy+1)=128;
    cnt=cnt+1;
    xxx=xxx-p;
end




cnt = 0;
while cnt<13 && xx>1 && xx<b(1)
    a(xx,yy) = 128;
    a(xx,yy+1)=128;
    cnt = cnt +1;
    xx = xx+p;
%imtool(a);
end



end

