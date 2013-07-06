clear all
clc
load 'def.mat'
load 'kinamtic.mat'
load 'Jacobian.mat'
load 'M.mat'
'computing C'
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