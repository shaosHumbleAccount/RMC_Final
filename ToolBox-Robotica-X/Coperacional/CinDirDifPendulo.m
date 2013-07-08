function Xp=CinDirDifPendulo(u)

l1=u(1);
l2=u(2);

q1=u(5);
q2=u(6);

q1p=u(7);
q2p=u(8);


J=[-l1*sin(q1)-l2*sin(q1+q2), -l2*sin(q1+q2); l1*cos(q1)+l2*cos(q1+q2), l2*cos(q1+q2)];

dJ=det(J);

xp=J*[q1p;q2p];

Xp=[xp;dJ];