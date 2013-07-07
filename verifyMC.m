clear all
clc
load def
load Jacobian
load kinematic
load M
load C

Mdot = sym(zeros(6,6));
for idx = 1:numOfJoint
    idx
    Mdot = simplify(Mdot + diff(M, q(idx))*qp(idx)  + diff(M, qp(idx))*qpp(idx));
end
N = Mdot - 2*C;
save('Mdot.mat','Mdot','N')