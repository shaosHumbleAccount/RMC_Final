clc
clear all

%kinematic parameters
syms l1 l2 l3 l4 l5 l6 real;
syms d1 d2 d4 d7 d8 d9 d10 real; %masses

%dynamic parameters
syms I111 I112 I113 I122 I123 I133 real;
syms I211 I212 I213 I222 I223 I233 real;
syms I311 I312 I313 I322 I323 I333 real;

syms I411 I412 I413 I422 I423 I433 real;
syms I511 I512 I513 I522 I523 I533 real;
syms I611 I612 I613 I622 I623 I633 real;

I1=[I111 I112 I113;
    I112 I122 I123;
    I113 I123 I133];

I2=[I211 I212 I213;
    I211 I222 I223;
    I213 I223 I233];

I3=[I311 I312 I313;
    I312 I322 I323;
    I313 I323 I333];

I4=[I411 I412 I413;
    I412 I422 I423;
    I413 I423 I433];

I5=[I511 I512 I513;
    I511 I522 I523;
    I513 I523 I533];

I6=[I611 I612 I613;
    I612 I622 I623;
    I613 I623 I633];

I_s = [{I1} {I2} {I3} {I4} {I5} {I6}];

syms m1 m2 m3 m4 m5 m6 real; %masses
m_s = [m1;m2;m3;m4;m5;m6];


%Joint Varible
syms q1 q2 q3 q4 q5 q6 qp1 qp2 qp3 qp4 qp5 qp6 real;

q=[q1;q2;q3;q4;q5;q6];
qp=[qp1;qp2;qp3;qp4;qp5;qp6];     %Vector of velocity of angle


g=sym('g','real');           %gravity
syms pi,'real';     %% this is important, if it not do like this, cos(pi/2) will not be =0;
syms alpha,'real';

syms g_vec  P  'real';
g_vec = [0;0;-g];

syms qp1r qp2r qp3r qp4r qp5r qp6r  real
syms qpp1r qpp2r qpp3r qpp4r qpp5r qpp6r real
qpr = [qp1r;qp2r;qp3r;qp4r;qp5r;qp6r];
qppr = [qpp1r;qpp2r;qpp3r;qpp4r;qpp5r;qpp6r];

save('def.mat');
%------------------------------------------------------------------%

%compute Transformation Matrix
HT1_0 = dh2tran(q1, d1, l1, -pi/2);

HT2_1 = dh2tran(q2 - pi/2, d2, l2, 0);
HT2_0 = HT1_0*HT2_1;

HT3_2 = dh2tran(q3 + pi/2, 0 , 0, pi/2);
HT3_0 = HT2_0*HT3_2;

HT4_3 = dh2tran(q4, d4, 0, -pi/2);
HT4_0 = HT3_0*HT4_3;

HT5_4 = dh2tran(q5, 0 , 0, pi/2);
HT5_0 = HT4_0*HT5_4;

HT6_5 = dh2tran(q6, 0 , 0, 0);
HT6_0 = HT5_0*HT6_5;

HTcm1_0 = dh2tran(q1 + alpha, d7, l3, 0);

HTcm2_1 = dh2tran(q2 - pi/2, d8, l4, 0);
HTcm2_0 = HT1_0*HTcm2_1;

HTcm3_2 = dh2tran(q3, 0 , l5, 0);
HTcm3_0 = HT2_0*HTcm3_2;

HTcm4_3 = dh2tran(q4, d9, 0, 0);
HTcm4_0 = HT3_0*HTcm4_3;

HTcm5_4 = dh2tran(q5 - pi/2, 0 , l6, 0);
HTcm5_0 = HT4_0*HTcm5_4;

HTcm6_5 = dh2tran(q6, d10 , 0, 0);
HTcm6_0 = HT5_0*HTcm6_5;


HTi0_s(1) = {HT1_0};
HTi0_s(2) = {HT2_0};
HTi0_s(3) = {HT3_0};
HTi0_s(4) = {HT4_0};
HTi0_s(5) = {HT5_0};
HTi0_s(6) = {HT6_0};
HTcmi0_s(1) = {HTcm1_0};
HTcmi0_s(2) = {HTcm2_0};
HTcmi0_s(3) = {HTcm3_0};
HTcmi0_s(4) = {HTcm4_0};
HTcmi0_s(5) = {HTcm5_0};
HTcmi0_s(6) = {HTcm6_0};

numOfJoint = 6;
isRevolute = [1 1 1 1 1 1];


disp('Computing Jacobians')

save('kinamtic.mat','numOfJoint','isRevolute','HTcmi0_s','HTi0_s')

%Compute Jacobians (Jcm_s)
for idxOfCM = 1:numOfJoint
    curJcm = sym(zeros(6,numOfJoint));
    curHTcm = HTcmi0_s{idxOfCM};
    
    z = [0;0;1];
    tcm  = curHTcm(1:3,4);
    
    if(isRevolute(1))
        curJcm(1:3,1) = cross(z, tcm);
        curJcm(4:6,1) = z;
    else
        curJcm(1:3,1) = z;
        curJcm(4:6,1) = [0;0;0];
    end
    
    for idxOfJoint = 2:idxOfCM
        curHT = HTi0_s{idxOfJoint - 1};
        
        z = curHT(1:3,3);
        tlink = curHT(1:3,4);
        
        if(isRevolute(idxOfJoint))
            t = cross(z, (tcm - tlink));
            curJcm(1:3,idxOfJoint) = cross(z, (tcm - tlink));
            curJcm(4:6,idxOfJoint) = z;
        else
            curJcm(1:3,idxOfJoint) = z;
            curJcm(4:6,idxOfJoint) = [0;0;0];
        end
    end
    Jcm_s(idxOfCM) = {simple(curJcm)};
end
save('Jacobian.mat','Jcm_s')

disp('computing M')
%Compute M
M = sym(zeros(numOfJoint,numOfJoint));
for idxOfJoint = 1:numOfJoint
    idxOfJoint
    curJcm = Jcm_s{idxOfJoint};
    Jv = curJcm(1:3,1:numOfJoint);
    Jw = curJcm(4:6,1:numOfJoint);
    
    curHT = HTi0_s{idxOfJoint};
    R = curHT(1:3,1:3);
    
    M = simple(M + m_s(idxOfJoint)*Jv'*Jv + Jw'*R*I_s{idxOfJoint}*R'*Jw);
end
save('M.mat','M')


% tau = M*qppr + C*qpr + G
% 
% save('tau.mat','qpr','qppr','tau')
% pause
% 
% Theta(1,1)=I122;
% Theta(2,1)=I322;
% Theta(3,1)=I222;
% Theta(4,1)=I211;
% Theta(5,1)=I311;
% Theta(6,1)=I212;
% Theta(7,1)=l2^2*m2;C
% Theta(8,1)=l2^2*m3;
% Theta(9,1)=l3^2*m3;
% Theta(10,1)=I312;
% Theta(11,1)=l2*l3*m3;
% Theta(12,1)=I323;
% Theta(13,1)=I213;
% Theta(14,1)=I313;
% Theta(15,1)=I223;
% Theta(16,1)=I233;
% Theta(17,1)=I333;
% Theta(18,1)=l3*m3;
% Theta(19,1)=l2*m3;
% Theta(20,1)=l2*m2;


% 
% numOfPara = 0;
% expandedTau = expand(tau);
% for jointIdx = 1:length(expandedTau)
%     terms = children(expandedTau(jointIdx));
%     for termIdx = 1:length(terms)
%         para = sym('1');
%         term = terms(termIdx);
%         elems = children(term);
%         for elemIdx = 1:length(elems)
%             elemAsStr = char(elems(elemIdx));
%             if(isempty(strfind(elemAsStr,'q')) && (...
%                     ~isempty(strfind(elemAsStr,'m')) ||...
%                     ~isempty(strfind(elemAsStr,'l')) || ...
%                     ~isempty(strfind(elemAsStr,'I'))))
%                 para = para*elems(elemIdx);
%             end
%         end
%         if(para ~= 1)
%             hasSame = false;
%             for paraIdx = 1:numOfPara
%                 if(Para(paraIdx) == para)
%                     hasSame = true;
%                     break;
%                 end
%             end
%             if(~hasSame)
%                 numOfPara = numOfPara + 1;
%                 Para(numOfPara) = para;
%             end
%         end
%     end
% end
% 
% Yr = sym(zeros(3,20));
% Yr(1,1)= mycoeff(tau(1),I122);
% Yr(1,2)= mycoeff(tau(1),I322);
% Yr(1,3)= mycoeff(tau(1),I222);
% Yr(1,4)= mycoeff(tau(1),I211);
% Yr(1,5)= mycoeff(tau(1),I311);
% Yr(1,6)= mycoeff(tau(1),I212);
% Yr(1,7)= mycoeff2(mycoeff(tau(1),m2),l2);
% Yr(1,8)= mycoeff2(mycoeff(tau(1),m3),l2);
% Yr(1,9)= mycoeff2(mycoeff(tau(1),m3),l3);
% Yr(1,10)=mycoeff(tau(1),I312);
% Yr(1,11)=mycoeff(mycoeff(mycoeff(tau(1),m3),l2),l3);
% Yr(1,12)=mycoeff(tau(1),I323);
% Yr(1,13)=mycoeff(tau(1),I213);
% Yr(1,14)=mycoeff(tau(1),I313);
% Yr(1,15)=mycoeff(tau(1),I223);
% Yr(1,16)=mycoeff(tau(1),I233);
% Yr(1,17)=mycoeff(tau(1),I333);
% Yr(1,18)=mycoeff0(mycoeff(mycoeff(tau(1),m3),l3),l2);
% Yr(1,19)=mycoeff0(mycoeff(mycoeff(tau(1),m3),l2),l3);
% Yr(1,20)=mycoeff0(mycoeff(mycoeff(tau(1),m2),l2),l3);
% Yr(2,1)= mycoeff(tau(2),I122);
% Yr(2,2)= mycoeff(tau(2),I322);
% Yr(2,3)= mycoeff(tau(2),I222);
% Yr(2,4)= mycoeff(tau(2),I211);
% Yr(2,5)= mycoeff(tau(2),I311);
% Yr(2,6)= mycoeff(tau(2),I212);
% Yr(2,7)= mycoeff2(mycoeff(tau(2),m2),l2);
% Yr(2,8)= mycoeff2(mycoeff(tau(2),m3),l2);
% Yr(2,9)= mycoeff2(mycoeff(tau(2),m3),l3);
% Yr(2,10)=mycoeff(tau(2),I312);
% Yr(2,11)=mycoeff(mycoeff(mycoeff(tau(2),m3),l2),l3);
% Yr(2,12)=mycoeff(tau(2),I323);
% Yr(2,13)=mycoeff(tau(2),I213);
% Yr(2,14)=mycoeff(tau(2),I313);
% Yr(2,15)=mycoeff(tau(2),I223);
% Yr(2,16)=mycoeff(tau(2),I233);
% Yr(2,17)=mycoeff(tau(2),I333);
% Yr(2,18)=mycoeff0(mycoeff(mycoeff(tau(2),m3),l3),l2);
% Yr(2,19)=mycoeff0(mycoeff(mycoeff(tau(2),m3),l2),l3);
% Yr(2,20)=mycoeff0(mycoeff(mycoeff(tau(2),m2),l2),l3);
% Yr(3,1)= mycoeff(tau(3),I122);
% Yr(3,2)= mycoeff(tau(3),I322);
% Yr(3,3)= mycoeff(tau(3),I222);
% Yr(3,4)= mycoeff(tau(3),I211);
% Yr(3,5)= mycoeff(tau(3),I311);
% Yr(3,6)= mycoeff(tau(3),I212);
% Yr(3,7)= mycoeff2(mycoeff(tau(3),m2),l2);
% Yr(3,8)= mycoeff2(mycoeff(tau(3),m3),l2);
% Yr(3,9)= mycoeff2(mycoeff(tau(3),m3),l3);
% Yr(3,10)=mycoeff(tau(3),I312);
% Yr(3,11)=mycoeff(mycoeff(mycoeff(tau(3),m3),l2),l3);
% Yr(3,12)=mycoeff(tau(3),I323);
% Yr(3,13)=mycoeff(tau(3),I213);
% Yr(3,14)=mycoeff(tau(3),I313);
% Yr(3,15)=mycoeff(tau(3),I223);
% Yr(3,16)=mycoeff(tau(3),I233);
% Yr(3,17)=mycoeff(tau(3),I333);
% Yr(3,18)=mycoeff0(mycoeff(mycoeff(tau(3),m3),l3),l2);
% Yr(3,19)=mycoeff0(mycoeff(mycoeff(tau(3),m3),l2),l3);
% Yr(3,20)=mycoeff0(mycoeff(mycoeff(tau(3),m2),l2),l3);
% 
% for i = 1:3
%     for j = 1:20
%         s(i,j) = {sprintf('Yr(%d,%d) = %s;\n', i ,j , char(Yr(i,j)))};
%     end
% end
% ts = '';
% for i = 1:3
%     for j = 1:20
%         ts = sprintf('%s%s',ts,s{i,j});
%     end
% end
