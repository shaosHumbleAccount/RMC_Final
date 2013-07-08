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
        k
        j
        for i = 1:numOfJoint
            C(k,j) = C(k,j) + (1/2)*(diff(M(k,j), q(i)) + diff(M(k,i), q(j)) - diff(M(i,j), q(k)))*qp(i);
        end
        %filename = sprintf('Ck%dj%d',k,j);
        %save(filename,'C');
    end
end
save('unsimpled_C.mat','C')

disp('simple start')
C = simplify(C);
disp('simple done')
save('C.mat','C')

id = fopen('c.txt','w');
for row = 1:6
    for col = 1:6
        s = sprintf('C(%d,%d) = %s;\n',row,col,char(C(row,col)));
        fprintf(id,s);
    end
end
fclose(id);