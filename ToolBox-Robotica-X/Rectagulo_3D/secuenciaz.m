function Z=secuenciaz(u)

t0=u(1);
t1=u(2);
t2=u(3);
t3=u(4);
t4=u(5);

z0=u(6);
z1=u(7);
z2=u(8);
z3=u(9);
z4=u(10);

v0=u(11);
v1=u(12);
v2=u(13);
v3=u(14);
v4=u(15);

t=u(16);

if ((t>=t0) && (t<t1))
    Z(1)=z0;
    Z(2)=z1;
    Z(3)=t0;
    Z(4)=t1;
    Z(5)=v0;
    Z(6)=v1;
elseif ((t>=t1) && (t<t2))
    Z(1)=z1;
    Z(2)=z2;
    Z(3)=t1;
    Z(4)=t2;
    Z(5)=v1;
    Z(6)=v2;
elseif ((t>=t2) && (t<t3))
    Z(1)=z2;
    Z(2)=z3;
    Z(3)=t2;
    Z(4)=t3;
    Z(5)=v2;
    Z(6)=v3;    
elseif ((t>=t3) && (t<=t4))
    Z(1)=z3;
    Z(2)=z4;
    Z(3)=t3;
    Z(4)=t4;    
    Z(5)=v3;
    Z(6)=v4;    
end

    
