function Q=CinInvPendulo(u)

l1=u(1);
l2=u(2);

x=u(3);
y=u(4);

conf=u(5); %depende de la configuracion del robot (no importa si no lo consideras) 

D=(x^2+y^2-l1^2-l2^2)/(2*l1*l2);

Q(2)=atan2((conf*sqrt(1-D^2)),D);

Q(1)=atan2(y,x)-atan2((l2*sin(Q(2))),(l1+l2*cos(Q(2))));
