function Tao=CPDOperacional(u)

% q1d=u(1);
% q2d=u(2);
% Qd=[q1d;q2d];
% q1dp=u(3);
% q2dp=u(4);
% Qdp=[q1dp;q2dp];
% q1dpp=u(5);
% q2dpp=u(6);
% Qdpp=[q1dpp;q2dpp];

xd=u(1);
xdp=u(2);
xdpp=u(3);

yd=u(4);
ydp=u(5);
ydpp=u(6);

Xd=[xd;yd];
Xdp=[xdp;ydp];
Xdpp=[xdpp;ydpp];
% Parametros

m1=u(15);
m2=u(16);

l1=u(17);
l2=u(18);
l11=u(19);
l21=u(20);

I331=u(21);
I332=u(22);

g=u(23);

% Posicion operacional

x=u(24);
y=u(25);
xp=u(26);
yp=u(27);


X=[x;y];
Xp=[xp;yp];

Dx=X-Xd;
Dxp=Xp-Xdp;


Kd=[u(7) 0; 0 u(8)];

Alfa=[u(9) 0; 0 u(10)];

q1=u(11);
q2=u(12);
Q=[q1;q2];
q1p=u(13);
q2p=u(14);
Qp=[q1p;q2p];


Jop=[-l2*sin(q1+q2)-l1*sin(q1), -l2*sin(q1+q2); l2*cos(q1+q2)+l1*cos(q1), l2*cos(q1+q2)];
Jopp=[-(q1p+q2p)*l2*cos(q1+q2)-q1p*l1*cos(q1), -(q1p+q2p)*l2*cos(q1+q2); -(q1p+q2p)*l2*sin(q1+q2)-q1p*l1*sin(q1), -(q1p+q2p)*l2*sin(q1+q2)];

iJop=inv(Jop);

Xrp=Xdp-Alfa*Dx;
Xrpp=Xdpp-Alfa*Dxp;

Qrp=iJop*Xrp;
Qrpp=iJop*(Xrpp-Jopp*Qrp);


q1rp=Qrp(1);
q2rp=Qrp(2);
q1rpp=Qrpp(1);
q2rpp=Qrpp(2);

Sq=Qp-Qrp;

%Regresor

Yr(1,1)=q1rpp;
Yr(1,2)=q1rpp+q2rpp;
Yr(1,3)=Yr(1,1);
Yr(1,4)=Yr(1,3);
Yr(1,5)=Yr(1,2);
Yr(1,6)=sin(q1);
Yr(1,7)=Yr(1,6);
Yr(1,8)=sin(q1+q2);
Yr(1,9)=2*q1rpp*cos(q2)+q2rpp*cos(q2)-q2p*q2rp*sin(q2)-q1rp*q2p*sin(q2)-q1p*q2rp*sin(q2);

Yr(2,1)=0;
Yr(2,2)=Yr(1,2);
Yr(2,3)=0;
Yr(2,4)=0;
Yr(2,5)=Yr(1,2);
Yr(2,7)=0;
Yr(2,6)=0;
Yr(2,8)=Yr(1,8);
Yr(2,9)=q1rpp*cos(q2)+q1p*q1rp*sin(q2);

Teta=[I331;I332;l1*l1*m2;m1*l11*l11;m2*l21*l21;g*l1*m2;g*m1*l11;g*m2*l21;l1*m2*l21];

Tao=-Kd*Sq+Yr*Teta;






