function Xp=CinDifDir(u)

q1=u(1);
q2=u(2);
q3=u(3);

q1p=u(4);
q2p=u(5);
q3p=u(6);

Qp=[q1p;q2p;q3p];

l1=2.5;
l2=1.6;

J(1,1)=(sin (q1))*(l1*(sin (q2))-(l2*cos(q2+q3)));
J(1,2)=(cos (q1))*(-l1*(cos (q2))-(l2*sin(q2+q3)));
J(1,3)=-l2*(cos (q1))*(sin(q2+q3));

J(2,1)=(cos (q1))*(-l1*(sin (q2))+l2*(cos(q2+q3)));
J(2,2)=(sin (q1))*(-l1*(cos (q2))-l2*(sin(q2+q3)));
J(2,3)=-l2*(sin(q1))*(sin(q2+q3));

J(3,1)=0;
J(3,2)=-l1*(sin (q2))+l2*(cos(q2+q3));
J(3,3)=l2*(cos(q2+q3));

Xp=J*Qp;


% Xp=[xp];





