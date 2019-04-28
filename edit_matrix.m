function [ a ] = edit_matrix( a, res_value, mat1, num_loop_a, x1, y1, x2 )
%EDIT_MATRIX This is to edit matrix 'a' according to 'mat1'
b = size(a);
for i=1:b(1)
    for j=1:b(2)
        if mat1(i,j)== res_value;
            a(i,j) = num_loop_a;
        end
    end
end

end

