function S=ScalePol5G(u)

xo=u(1);
xf=u(2);

S(1)=(u(3)*(xf-xo))+xo;
S(2)=(u(4)*(xf-xo));
S(3)=(u(5)*(xf-xo));