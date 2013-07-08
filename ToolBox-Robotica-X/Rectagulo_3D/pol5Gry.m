function pol=pol5Gry(u)

yi=u(1);
yf=u(2);
ti=u(3);
tf=u(4);
vi=u(5);
vf=u(6);

t=u(7);


T=[1 ti ti^2 ti^3  ti^4    ti^5;
   1 tf tf^2 tf^3  tf^4    tf^5;
   0 1 2*ti 3*ti^2 4*ti^3  5*ti^4;
   0 1 2*tf 3*tf^2 4*tf^3  5*tf^4;
   0 0 2    6*ti   12*ti^2 20*ti^3;
   0 0 2    6*tf   12*tf^2 20*tf^3];
X=[yi;yf;0;0;0;0];

A=inv(T)*X;

pol(1)=A(1)+ A(2)*t+  A(3)*t^2+  A(4)*t^3+    A(5)*t^4+    A(6)*t^5;
pol(2)=   0+ A(2)  +2*A(3)*t  +3*A(4)*t^2+  4*A(5)*t^3+  5*A(6)*t^4;
pol(3)=   0+ 0     +2*A(3)    +6*A(4)*t  + 12*A(5)*t^2+ 20*A(6)*t^3;

