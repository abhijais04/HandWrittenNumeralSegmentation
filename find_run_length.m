function [ R ] = find_run_length( im_res, res_code )
%FIND_RUN_LENGTH Summary of this function goes here
%   Detailed explanation goes here

b = size(im_res);
fr = zeros(1,b(2));


for i=1:b(1)
    for j=1:b(2)
        if im_res(i,j)==0
            y1 = j;
            while im_res(i,j)==0
                im_res(i,j)=1;
                j = j+1;
            end
            y2=j;
            if im_res(i,y2+1)==res_code || im_res(i,y1-1)==res_code
                black_run = y2 - y1;
                %j=j+1;
                %fprintf('black_run %d %d %d\n',i,y2,y1);
                if black_run==0
                    %fprintf('black_run %d %d %d\n',i,y2,y1);
                else
                    fr(black_run) = fr(black_run) + 1;
                end
            end
        end
    end
end
%imtool(im_res);

mx=0; l_mx=0;
for i=1:b(2)
    if mx < fr(i)
        mx = fr(i);
        l_mx = i;
    end
end

R = l_mx;

end

