clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'

%compute G
syms P g real;

%add up potential energy
disp('computing P');
for idxOfCM = 1:numOfJoint
    P = P + m_s(idxOfCM)*g_vec'*(HTcmi0_s{idxOfCM}(1:3,4));
end
P = simple(expand(P));
disp('computing P done');
disp('computing G');
for idxOfCM = 1:numOfJoint
    G(idxOfCM,1) = diff(P, q(idxOfCM));
end
disp('start simplifying G')
G = simple(G);
disp('simplifying G done')
save('G.mat','G')
