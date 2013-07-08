function X=CinDirPendulo(u)

l1=u(1);
l2=u(2);
q1=u(3);
q2=u(4);


X(1)=l1*cos(q1)+l2*cos(q1+q2);
X(2)=l1*sin(q1)+l2*sin(q1+q2);
