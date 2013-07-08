function p=grafica(alpha, a, teta, d, alpha1, a1, teta1, d1)

% alpha=u(1);
% a=u(2);
% teta=u(3);
% d=u(4);
% 
% alpha1=u(5);
% a1=u(6);
% teta1=u(7);
% d1=u(8);

L1=link([alpha a teta d]);
L2=link([alpha1 a1 teta1 d1]);

r=robot({L1 L2});
p=plot(r,[0 0]);
end







