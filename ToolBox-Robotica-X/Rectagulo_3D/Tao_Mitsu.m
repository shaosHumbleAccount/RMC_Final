function Tao=Tao_Mitsu(u)

% I111=0.001;
% I121=0.002;
% I131=0.003;
% 
% I221=0.002;
% I231=0.003;

I331=0.003;

I112=0.001;
I122=0.002;
I132=0.003;

I222=0.002;
I232=0.003;

I332=0.003;

I113=0.001;
I123=0.002;
I133=0.003;

I223=0.002;
I233=0.003;

I333=0.003;

l1=2.5;
l2=1.6;
% h1=1.74;
l11=1.25;
l21=0.8;

% m1=2.0;
m2=1.5;
m3=2.0;

g=9.81;

q1=u(1);
q2=u(2);
q3=u(3);

Q=[q1;q2;q3];

q1p=u(4);
q2p=u(5);
q3p=u(6);

Qp=[q1p;q2p;q3p];

%&&&&&&&&&Trayectoria&&&&&&&&&&&&%

xd=u(7);
xdp=u(8);
xdpp=u(9);

yd=u(10);
ydp=u(11);
ydpp=u(12);

zd=u(13);
zdp=u(14);
zdpp=u(15);

Xd=[xd;yd;zd];

% plot3(xd,yd,zd);
% hold on;
% grid on;

Xdp=[xdp;ydp;zdp];
Xdpp=[xdpp;ydpp;zdpp];

%&&&&&&&&&&&& Cinemática diferencial directa &&&&&&&&&&&&&

xp=u(16);
yp=u(17);
zp=u(18);

Xp=[xp;yp;zp];

%&&&&&&&&&&&&&& Cinemática directa &&&&&&&&&&&&&&&&&

x=u(19);
y=u(20);
z=u(21);

X=[x;y;z];

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
Dx=X-Xd;

Dxp=Xp-Xdp;

Kd=[30 0 0; 0 30 0; 0 0 30];

Alfa=[0.001 0 0; 0 0.001 0; 0 0 0.001];

%&&&&&& Jacobiano operacional &&&&&&&&&&&&

Jop(1,1)=(sin(q1))*(l1*(sin(q2))-(l2*cos(q2+q3)));
Jop(1,2)=(cos(q1))*(-l1*(cos(q2))-(l2*sin(q2+q3)));
Jop(1,3)=-l2*(cos(q1))*(sin(q2+q3));

Jop(2,1)=(cos(q1))*(-l1*(sin(q2))+l2*(cos(q2+q3)));
Jop(2,2)=(sin(q1))*(-l1*(cos(q2))-l2*(sin(q2+q3)));
Jop(2,3)=-l2*(sin(q1))*(sin(q2+q3));

Jop(3,1)=0;
Jop(3,2)=-l1*(sin(q2))+l2*(cos(q2+q3));
Jop(3,3)=l2*(cos(q2+q3));

Dt1=det(Jop);
iJop=inv(Jop);


Jopp(1,1)=cos(q1)*q1p*l1*cos(q2)*q2p-l2*sin(q2+q3)*(q2p+q3p);
Jopp(1,2)=-sin(q1)*q1p*l1*sin(q2)*q2p-l2*cos(q2+q3)*(q2p+q3p);
Jopp(1,3)=l2*sin(q1)*q1p*(cos(q2+q3))*(q2p+q3p);

Jopp(2,1)=sin(q1)*q1p*l1*cos(q2)*q2p-l2*(sin(q2+q3))*(q2p+q3p);
Jopp(2,2)=cos(q1)*q1p*l1*sin(q2)*q2p-l2*cos(q2+q3)*(q2p+q3p);
Jopp(2,3)=-l2*cos(q1)*(q1p)*cos(q2+q3)*(q2p+q3p);

Jopp(3,1)=0;
Jopp(3,2)=-l1*cos(q2)*q2p-l2*sin(q2+q3)*(q2p+q3p);
Jopp(3,3)=-l2*sin(q2+q3)*(q2p+q3p);

Dt2=det(Jopp);

Xrp=Xdp-Alfa*Dx;
Xrpp=Xdpp-Alfa*Dxp;

Qrp=iJop*Xrp;

Qrpp=iJop*(Xrpp-Jopp*Qrp);

q1pr=Qrp(1,1);
q2pr=Qrp(2,1);
q3pr=Qrp(3,1);

q1ppr=Qrpp(1,1);
q2ppr=Qrpp(2,1);
q3ppr=Qrpp(3,1);

%Qpn=iJop*Xp;

Sq=Qp-Qrp;

%iJop*(Xp-Xrp);


%&&&REGRESOR %%%%%%%%%%%%%%%%%%
 %+triz Y
Y(1,1)= cos(2*q2+2*q3)*q1p*q2pr + cos(2*q2+2*q3)*q1p*q3pr + 2*sin(q2+q3)*cos(q2+q3)*q1ppr + cos(2*q2+2*q3)*q1pr*q3p + cos(2*q2+2*q3)*q1pr*q2p;
Y(1,2)= - cos(2*q2+q3)*q1p*q2pr - cos(2*q2+q3)*q1pr*q2p + (1/2)*cos(q3)*q1pr*q3p - (1/2)*cos(2*q2+q3)*q1pr*q3p - 2*sin(q2)*cos(q2)*cos(q3)*q1ppr + 2*sin(q3)*q1ppr - 2*sin(q3)*cos(q2)^2*q1ppr + (1/2)*cos(q3)*q1p*q3pr - (1/2)*cos(2*q2+q3)*q1p*q3pr;
Y(1,3)= - sin(q2)*q2ppr - cos(q2)*q2p*q2pr;
Y(1,4)= cos(q2)*q2ppr - sin(q2)*q2p*q2pr;
Y(1,5)= - cos(2*q2)*q1p*q2pr - 2*sin(q2)*cos(q2)*q1ppr - cos(2*q2)*q1pr*q2p;
Y(1,6)= q1ppr - (1/2)*sin(2*q2+2*q3)*q1p*q2pr - (1/2)*sin(2*q2+2*q3)*q1pr*q2p - (1/2)*sin(2*q2+2*q3)*q1pr*q3p - 2*sin(q2)*sin(q3)*cos(q2)*cos(q3)*q1ppr + 2*cos(q2)^2*cos(q3)^2*q1ppr - cos(q3)^2*q1ppr - cos(q2)^2*q1ppr - (1/2)*sin(2*q2+2*q3)*q1p*q3pr;
Y(1,7)= q1ppr;
Y(1,8)= q1ppr + (1/2)*sin(2*q2)*q1p*q2pr + (1/2)*sin(2*q2)*q1pr*q2p - cos(q2)^2*q1ppr;
Y(1,9)= sin(q2+q3)*q2ppr + sin(q2+q3)*q3ppr + cos(q2+q3)*q2p*q3pr + cos(q2+q3)*q3p*q3pr + cos(q2+q3)*q2pr*q3p + cos(q2+q3)*q2p*q2pr;
Y(1,10)= (1/2)*sin(2*q2+2*q3)*q1p*q2pr + q1ppr - cos(q2+q3)^2*q1ppr + (1/2)*sin(2*q2+2*q3)*q1p*q3pr + (1/2)*sin(2*q2+2*q3)*q1pr*q3p + (1/2)*sin(2*q2+2*q3)*q1pr*q2p;
Y(1,11)= 0;
Y(1,12)= (1/2)*sin(2*q2)*q1p*q2pr + q1ppr - cos(q2)^2*q1ppr + (1/2)*sin(2*q2)*q1pr*q2p;
Y(1,13)= 0;
Y(1,14)= (1/2)*sin(2*q2)*q1p*q2pr + 1/2*sin(2*q2)*q1pr*q2p - cos(q2)^2*q1ppr*(1)+ q1ppr;
Y(1,15)= cos(q2+q3)*q3ppr + cos(q2+q3)*q2ppr - sin(q2+q3)*q2p*q2pr - sin(q2+q3)*q2p*q3pr - sin(q2+q3)*q3p*q3pr - sin(q2+q3)*q2pr*q3p;
Y(1,16)= cos(q2+q3)^2*q1ppr - (1/2)*sin(2*q2+2*q3)*q1p*q2pr - 1/2*sin(2*q2+2*q3)*q1p*q3pr - 1/2*sin(2*q2+2*q3)*q1pr*q3p - 1/2*sin(2*q2+2*q3)*q1pr*q2p;
Y(1,17)= 0;
Y(1,18)= cos(q2)^2*q1ppr - (1/2)*sin(2*q2)*q1p*q2pr - (1/2)*sin(2*q2)*q1pr*q2p;
Y(1,19)= 0;

Y(2,1)= - cos(2*q2+2*q3)*q1p*q1pr;
Y(2,2)= cos(q3)*q3p*q3pr + cos(q3)*q2pr*q3p + cos(q3)*q2p*q3pr + 2*sin(q3)*q2ppr + sin(q3)*q3ppr + cos(2*q2+q3)*q1p*q1pr;
Y(2,3)= - sin(q2)*q1ppr;
Y(2,4)= cos(q2)*q1ppr;
Y(2,5)= cos(2*q2)*q1p*q1pr;
Y(2,6)= 1/2*sin(2*q2+2*q3)*q1p*q1pr + q2ppr + q3ppr;
Y(2,7)= 0;
Y(2,8)= - (1/2)*sin(2*q2)*q1p*q1pr + q2ppr;
Y(2,9)= sin(q2+q3)*q1ppr;
Y(2,10)= - 1/2*sin(2*q2+2*q3)*q1p*q1pr;
Y(2,11)= cos(q2+q3);
Y(2,12)= - 1/2*sin(2*q2)*q1p*q1pr;
Y(2,13)= q2ppr+ q3ppr;
Y(2,14)= - 1/2*sin(2*q2)*q1p*q1pr+ q2ppr;
Y(2,15)= cos(q2+q3)*q1ppr;
Y(2,16)= (1/2)*sin(2*q2+2*q3)*q1p*q1pr;
Y(2,17)= - sin(q2);
Y(2,18)= (1/2)*sin(2*q2)*q1p*q1pr;
Y(2,19)= q2ppr;

Y(3,1)= - cos(2*q2+2*q3)*q1p*q1pr;
Y(3,2)= sin(q3)*q2ppr + 1/2*cos(2*q2+q3)*q1p*q1pr - (1/2)*cos(q3)*q1p*q1pr - cos(q3)*q2p*q2pr;
Y(3,3)= 0;
Y(3,4)= 0;
Y(3,5)= 0;
Y(3,6)= q2ppr + q3ppr + (1/2)*sin(2*q2+2*q3)*q1p*q1pr;
Y(3,7)= 0;
Y(3,8)= 0;
Y(3,9)= sin(q2+q3)*q1ppr; 
Y(3,10)= - 1/2*sin(2*q2+2*q3)*q1p*q1pr;
Y(3,11)= cos(q2+q3);
Y(3,12)= 0;
Y(3,13)= q2ppr + q3ppr;
Y(3,14)= 0;
Y(3,15)= cos(q2+q3)*q1ppr;
Y(3,16)= (1/2)*sin(2*q2+2*q3)*q1p*q1pr;
Y(3,17)= 0;
Y(3,18)= 0;
Y(3,19)= 0;

%+triz Theta
T(1,1) = I123;
T(2,1) = m3*l1*l21;
T(3,1) = I232;
T(4,1) = I132;
T(5,1) = I122;
T(6,1) = m3*l21^2;
T(7,1) = I331;
T(8,1) = m2*l11^2;
T(9,1) = I133;
T(10,1) = I113;
T(11,1) = m3*l21*g;
T(12,1) = I222;
T(13,1) = I333;
T(14,1) = m3*l1^2;
T(15,1) = I233;
T(16,1) = I223;
T(17,1) = m3*l1*g+ m2*l11*g;
T(18,1) = I112;
T(19,1) = I332;
% Sq
% Qp
% Qrp
% Y*T
tao=(-Kd*Sq)+(Y*T);
Tao=[tao(1,1);tao(2,1);tao(3,1);Dt1;Dt2;0];





