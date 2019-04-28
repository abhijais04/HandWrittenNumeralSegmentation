function [ res, fbp,lbp ] = check_connectivity_in_horizontal_line(a,x,val1,val2)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

res=0;
fbp=0;
lbp=0;
b = size(a);
fval = -1;
for i=1:b(2)
    if a(x,i) == val1
        tmp = i;
        while tmp < b(2) && a(x,tmp)==val1
            tmp = tmp+1;
        end
        fbp = tmp;
        while tmp < b(2) && a(x,tmp)==0
            tmp = tmp+1;
        end
        lbp = tmp-1;
        if a(x,tmp) == val2
            res=1;
        end
        
        fval=1;
    end
    if a(x,i) == val2
        tmp = i;
        while tmp < b(2) && a(x,tmp)==val2
            tmp = tmp+1;
        end
        fbp = tmp;
        while tmp < b(2) && a(x,tmp)==0
            tmp = tmp+1;
        end
        lbp = tmp-1;
        if a(x,tmp) == val1
            res=1;
        end
        fval=1;
    end
    if fval == 1
        break;
    end
end
if fval == 0
    fbp = 1;
    lbp = 1;
end

end

