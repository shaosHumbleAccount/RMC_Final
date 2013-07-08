function q=cinvMitsu(u)


x=u(1);
y=u(2);
z=u(3);

l1=2.5;
l2=1.6;
h1=1.74;    

D=(x^2+y^2+(z-h1)^2-l1^2-l2^2)/(2*l1*l2);
sD=sqrt(1-(D^2));

Conf=-1;
q(3,1)=atan2((D),(Conf*sD));
alf=((pi/2)-q(3,1));
teta=atan2((z-h1),(-(sqrt(x^2+y^2))));
si=atan2((l2*(sin(alf))),(l1+l2*cos(alf)));
eps=teta-si;
q(2,1)=(pi/2)-eps;
q(1,1)=atan2(y,x);
q=[q(1,1);q(2,1);q(3,1)];

