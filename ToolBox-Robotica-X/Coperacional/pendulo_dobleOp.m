function qpp=pendulo_dobleOp(u)

q1=u(1);
q2=u(2);
Q=[q1;q2];
q1p=u(3);
q2p=u(4);
Qp=[q1p;q2p];
%Parametros

m1=u(5);
m2=u(6);

l1=u(7);
l2=u(8);
l11=u(9);
l21=u(10);

I331=u(11);
I332=u(12);

g=u(13);


	

H(1,1)=m2*l1*l1+2*m2*(cos(q2))*l1*l21+m1*l11*l11+m2*l21*l21+I331+I332;
H(1,2)=m2*l21*l21+l1*m2*(cos(q2))*l21+I332;
H(2,1)=H(1,2);
H(2,2)=m2*l21*l21+I332;

C(1,1)=-q2p*l1*m2*l21*sin(q2);
C(1,2)=-q1p*l1*m2*l21*sin(q2)-q2p*l1*m2*l21*sin(q2);
C(2,1)=q1p*l1*m2*l21*sin(q2);
C(2,2)=0;


G(1,1)=g*m2*l21*sin(q1+q2)+g*l1*m2*sin(q1)+g*m1*l11*sin(q1);
G(2,1)=g*m2*l21*sin(q1+q2);

Tao=[u(14);u(15)];

Qpp=inv(H)*(Tao-C*Qp-G);

%Validacion de regresor
q1rpp=Qpp(1);
q2rpp=Qpp(2);

q1rp=Qp(1);
q2rp=Qp(2);


Y(1,1)=q1rpp;
Y(1,2)=q1rpp+q2rpp;
Y(1,3)=Y(1,1);
Y(1,4)=Y(1,3);
Y(1,5)=Y(1,2);
Y(1,6)=sin(q1);
Y(1,7)=Y(1,6);
Y(1,8)=sin(q1+q2);
Y(1,9)=2*q1rpp*cos(q2)+q2rpp*cos(q2)-q2p*q2rp*sin(q2)-q1rp*q2p*sin(q2)-q1p*q2rp*sin(q2);

Y(2,1)=0;
Y(2,2)=Y(1,2);
Y(2,3)=0;
Y(2,4)=0;
Y(2,5)=Y(1,2);
Y(2,7)=0;
Y(2,6)=0;
Y(2,8)=Y(1,8);
Y(2,9)=q1rpp*cos(q2)+q1p*q1rp*sin(q2);

Teta=[I331;I332;l1*l1*m2;m1*l11*l11;m2*l21*l21;g*l1*m2;g*m1*l11;g*m2*l21;l1*m2*l21];

Reg=H*Qpp+C*Qp+G-Y*Teta;

qpp=[Qpp;Reg];


