function ShowEFandCF( HT,R0_b)
%SHOWEFANDCF Summary of this function goes here
%   Detailed explanation goes here

Xn_0=HT(1:3,4);

Rn_0=HT(1:3,1:3);



Xn_b=R0_b*Xn_0;
Rn_b=R0_b*Rn_0;   


figure(1)
% End-effector
plot3(Xn_b(1),Xn_b(2),Xn_b(3),'m .','markersize',30);

off=0.01;
for i=2:10
    Xaux=Xn_b+i*off*Rn_b(1:3,1);
    plot3(Xaux(1),Xaux(2),Xaux(3),'r .','markersize',10);
    Xaux=Xn_b+i*off*Rn_b(1:3,2);
    plot3(Xaux(1),Xaux(2),Xaux(3),'g .','markersize',10);
    Xaux=Xn_b+i*off*Rn_b(1:3,3);
    plot3(Xaux(1),Xaux(2),Xaux(3),'b .','markersize',10);
end

hold on


end

