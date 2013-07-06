clear all
clc
load def
load Jacobian
load kinamtic
load M
load C
syms qpp1 qpp2 qpp3 qpp4 qpp5 qpp6 real
qpp = [qpp1;qpp2;qpp3;qpp4;qpp5;qpp6];

Mdot = sym(zeros(6,6));
for idx = 1:numOfJoint
    idx
    Mdot = simplify(Mdot + diff(M, q(idx))*qp(idx)  + diff(M, qp(idx))*qpp(idx));
end

save('Mdot.mat','Mdot')