function [ theta, x_s] = kalman( q, qp, qpp, tau, m, g_t)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sym m ;
delta_t = 0.01;
N = length(q);

P = diag([1 1 0.2 0.2 0.2 0.2 0.2]);%initial error cov

x = [q(1) qp(1) 0.2 0.1 0.1 1 1]'; %initial estimate state

Fric = (tau - g_t - m);

y = [q qp Fric];

%observation noise
R = [1e-1 0 0
    0 1e-1 0
    0 0 0.1];

%model noise
Q = diag([0.1 0.1 0.001 0.001 0.001 0.001 0.001 ]);

x_s = zeros(N,7);
x_s(1,:) = x;
for t = 2: N
  %symQ  = q(t);
  
  F = zeros(7,7);
  F(1,1) = 1; 
  F(1,2) = delta_t; 
  F(2,2) = 1; 
  F(3,3) = 1;
  F(4,4) = 1;
  F(5,5) = 1;
  F(6,6) = 1;
  F(7,7) = 1;
  
  Pf = F*P*F' + Q;
  
  x(1) = x(1) + delta_t*x(2);
  x(2) = x(2) + qpp(t-1)*delta_t;
  
  H = zeros(3,7);
  
  H(1,1) = 1;
 % H(1,2) = 0.01;
  H(2,2) = 1;
  H(3,1) = 0;
  
  H(3,2) = x(3) + 4*x(4)*x(6)*exp(2*x(2)*x(6)) / (1 + exp(2*x(2)*x(6)) )^2 ...%FIXME
  + 4*x(5)*x(7)*exp(2*x(2)*x(7))/(1+exp(2*x(2)*x(7)))^2;
  
  H(3,3) =  x(2);
  
  H(3,4) =  (1 - 2/(1 + exp(2*x(2)*x(6))));
  
  H(3,5) =  (1 - 2/(1 + exp(2*x(2)*x(7))));
  
  H(3,6) =  (4*x(4)*x(2)*exp(2*x(6)*x(2)) / (1 + exp(2*x(6)*x(2)))^2);
  
  H(3,7) =  (4*x(5)*x(2)*exp(2*x(7)*x(2)) / (1 + exp(2*x(7)*x(2)))^2);


  K = Pf*H'*inv(H*Pf*H' + R);
  
  P = (eye(7) - K*H) * Pf;
 
  h = [x(1); x(2); ...
      (x(3)*x(2) -x(4)*(1 - 2/(1 + exp(2 * x(2) * x(6)))) - x(5)*(1 - 2/(1 + exp(2 *x(2)*x(7)))))];
  
  x = x + K*(y(t,:)' - h);
  
  x_s(t,:) = x;
end
Bv = x(3);
Bf_1 = x(4);
Bf_2 = x(5);
w1 = x(6);
w2 = x(7);
theta = [Bv, Bf_1, Bf_2, w1, w2];
end

