function dte=Dterminante(u)

q1=u(1);
q2=u(2);
q3=u(3);

l1=2.5;
l2=1.6;

J(1,1)=(sin(q1))*(l1*(sin(q2))-(l2*cos(q2+q3)));
J(1,2)=cos(q1)*(-l1*(cos(q2)))-l2*(sin(q2+q3));
J(1,3)=(-l2*(cos(q1))*(sin(q2+q3)));

J(2,1)=((cos(q1))*(-l1*(sin(q2))+l2*cos(q2+q3)));
J(2,2)=(sin(q1))*(-l1*(cos(q2)))-l2*(sin(q2+q3));
J(2,3)=(-l2*(sin(q1))*(sin(q2+q3)));

J(3,1)= 0;
J(3,2)=-l1*sin(q2)+l2*cos(q2+q3);
J(3,3)=l2*cos(q2+q3);   
         
dJop=det(J);         

dte=dJop;
