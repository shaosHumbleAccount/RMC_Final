function Qd=GenTrayArticular(u)

t=u(1);
A1=u(2);
A2=u(3);

w1=2*pi/u(4);
w2=2*pi/u(5);


Qd(1)=A1*sin(w1*t);
Qd(2)=A2*sin(w2*t);
Qd(3)=w1*A1*cos(w1*t);
Qd(4)=w2*A2*cos(w2*t);
Qd(5)=-w1*w1*A1*sin(w1*t);
Qd(6)=-w2*w2*A2*sin(w2*t);
