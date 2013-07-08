function Y=secuenciay(u)

t0=u(1);
t1=u(2);
t2=u(3);
t3=u(4);
t4=u(5);

y0=u(6);
y1=u(7);
y2=u(8);
y3=u(9);
y4=u(10);

v0=u(11);
v1=u(12);
v2=u(13);
v3=u(14);
v4=u(15);

t=u(16);

if ((t>=t0) && (t<t1))
    Y(1)=y0;
    Y(2)=y1;
    Y(3)=t0;
    Y(4)=t1;
    Y(5)=v0;
    Y(6)=v1;
elseif ((t>=t1) && (t<t2))
    Y(1)=y1;
    Y(2)=y2;
    Y(3)=t1;
    Y(4)=t2;
    Y(5)=v1;
    Y(6)=v2;
elseif ((t>=t2) && (t<t3))
    Y(1)=y2;
    Y(2)=y3;
    Y(3)=t2;
    Y(4)=t3;
    Y(5)=v2;
    Y(6)=v3;    
elseif ((t>=t3) && (t<=t4))
    Y(1)=y3;
    Y(2)=y4;
    Y(3)=t3;
    Y(4)=t4;    
    Y(5)=v3;
    Y(6)=v4;    
end

    
