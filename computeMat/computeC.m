clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
disp('computing C');
%Compute C
C = sym(zeros(numOfJoint,numOfJoint));

for k = 1:numOfJoint
    for j = 1:numOfJoint
        fprintf('computing C(%d, %d)\n',k,j);
        for i = 1:numOfJoint
            C(k,j) = C(k,j) + (1/2)*(diff(M(k,j), q(i)) + diff(M(k,i), q(j)) - diff(M(i,j), q(k)))*qp(i);
        end
    end
end
save('unsimpled_C.mat','C')

disp('simplifying C ...')

for row = 1:numOfJoint
    for col = 1:numOfJoint
        fprintf('simplifying C(%d,%d)\n',row, col);
        C(row,col) = simplify(expand(C(row,col)));
    end
end
disp('simplification done')
save('C.mat','C')

id = fopen('C.txt','w');
for row = 1:numOfJoint
    for col = 1:numOfJoint
        s = sprintf('C(%d,%d) = %s;\n',row,col,char(C(row,col)));
        fprintf(id,s);
    end
end
fclose(id);