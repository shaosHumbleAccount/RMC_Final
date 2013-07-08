function X=cdirMitsu(u)

q1=u(1);
q2=u(2);
q3=u(3);

l1=2.5;
l2=1.6;
h1=1.74;

x(1,1)=((-l1*(sin (q2))*(cos (q1)))+(l2*(cos(q2+q3))*(cos (q1))));
x(2,1)=((-l1*(sin (q2))*(sin (q1)))+(l2*(cos(q2+q3))*(sin (q1))));
x(3,1)=(h1+(l1*(cos (q2)))+(l2*(sin(q2+q3))));
X=[x(1,1);x(2,1);x(3,1)];
%plot3(X(1,1),X(2,1),X(3,1));






