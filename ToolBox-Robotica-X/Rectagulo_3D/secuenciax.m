function X=secuenciax(u)

t0=u(1);
t1=u(2);
t2=u(3);
t3=u(4);
t4=u(5);

x0=u(6);
x1=u(7);
x2=u(8);
x3=u(9);
x4=u(10);

v0=u(11);
v1=u(12);
v2=u(13);
v3=u(14);
v4=u(15);

t=u(16);

if ((t>=t0) && (t<t1))
    X(1)=x0;
    X(2)=x1;
    X(3)=t0;
    X(4)=t1;
    X(5)=v0;
    X(6)=v1;
elseif ((t>=t1) && (t<t2))
    X(1)=x1;
    X(2)=x2;
    X(3)=t1;
    X(4)=t2;
    X(5)=v1;
    X(6)=v2;
elseif ((t>=t2) && (t<t3))
    X(1)=x2;
    X(2)=x3;
    X(3)=t2;
    X(4)=t3;
    X(5)=v2;
    X(6)=v3;    
elseif ((t>=t3) && (t<=t4))
    X(1)=x3;
    X(2)=x4;
    X(3)=t3;
    X(4)=t4;    
    X(5)=v3;
    X(6)=v4;    
end

    
