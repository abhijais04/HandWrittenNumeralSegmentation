function [ im_res ] = separate( im_res )
%SEPARATE Summary of this function goes here
%   Detailed explanation goes here

b = size(im_res);
a = im_res;
for i=1:b(1)
    for j=1:b(2)
        if a(i,j)==0
            a(i,j)=200;
            % left -> right
            for x=1:b(1)
                for y=1:b(2)
                    if a(x,y)==0
                        if (a(x,y-1)==200 || a(x-1,y)==200)
                            a(x,y)=200;
                        end
                    end
                end
            end
            
            % right -> left
            for x=b(1)-1:-1:1
                for y=b(2)-1:-1:1
                    if a(x,y)==0
                        if (a(x,y+1)==200 || a(x+1,y)==200)
                            a(x,y)=200;
                        end
                    end
                end
            end
            imtool(a);
            c = zeros(b(1),b(2));
            for x=1:b(1)
                for y=b(2)
                    if a(x,y) ~= 200
                        c(x,y)=1;
                    end
                end
            end
            imtool(c);
            for x=1:b(1)
                for y=1:b(2)
                    if a(x,y)==200
                        a(x,y)=1;
                    end
                end
            end
        end
    end
end

end

