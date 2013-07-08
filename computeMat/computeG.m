clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
numOfJoint = 6;
'computing G'
%compute G
%add up potential energy
syms g_vec g P  'real';
g_vec = [0;0;-g];

for idxOfCM = 1:numOfJoint
    P = simple(P + m_s(idxOfCM)*g_vec'*(HTcmi0_s{idxOfCM}(1:3,4)));
end
for idxOfCM = 1:numOfJoint
    G(idxOfCM,1) = diff(P, q(idxOfCM));
end
save('unsimpled_G.mat','G')
disp('start simple')
G = simple(G);
save('G.mat','G')
