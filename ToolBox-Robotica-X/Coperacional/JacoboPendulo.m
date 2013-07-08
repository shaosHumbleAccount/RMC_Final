function J=JacoboPendulo(u)

l1=u(1);
l2=u(2);
q1=u(3);
q2=u(4);


j=[-l2*sin(q1+q2)-l1*sin(q1), -l2*sin(q1+q2); l2*cos(q1+q2)+l1*cos(q1), l2*cos(q1+q2)];

J=det(j);
