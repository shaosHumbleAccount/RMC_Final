clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
load C

C_simple = sym(zeros(numOfJoint,numOfJoint));

id = fopen('c_simple.txt','w');
for row = 1:6
    for col = 1:6
        row,col
        C_simple(row,col) = simple(C(row,col));
        s = sprintf('C(%d,%d) = %s;\n',row,col,char(C_simple(row,col)));
        fprintf(id,s);
    end
end
fclose(id);

C = C_simple
save('C_simple.mat','C')