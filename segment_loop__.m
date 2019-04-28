function [ a ] = segment_loop__( a,x,y1,y2, original_image, folderAddr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% fprintf('Segmenting by second method .......\n');



b = size(a);

y = (y1 + y2) / 2;

x = int32(x);
y = int32(y);
im = highlight_point( a, x, y );
%imtool(original_image);
im = print_image( original_image , im, folderAddr, 'cuttingPoint.png' );
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




xxx = -1;
yyy = -1;

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
    int32(yy);
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

    xx = xx+1;
end



cnt=0;
while cnt<13 && xxx>1
    a(xxx,yyy) = 128;
    a(xxx,yyy+1)=128;
    cnt=cnt+1;
    xxx=xxx-1;
end




cnt = 0;
while cnt<13 && xx>1 && xx<b(1)
    a(xx,yy) = 128;
    a(xx,yy+1)=128;
    cnt = cnt +1;
    xx = xx+1;
%imtool(a);
end


%imtool(a);


end

