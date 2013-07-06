function [ theta ] = kalman( q. qp, qpp, tau, m, g_t, diff_g_x1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sym m ;

N = length(q);

q = zeros(N,1);

qp = zeros(N,1);

tau = zeros(N,1);

P = zeros(7,7);

K = zeros(7,3);

x = [q(1) qp(1) 0 0 0 0 0];

y = [q qp qpp];

R = zeros(3,3);
cd 
for t = 1: N
  H = zeros(7,3);
  H(1,1) = 1;
  H(2,2) = 1;
  symQ  = q(t);
  H(3,1) = eval(-diff_g_x1);
  
  H(3,2) = -x(3) - 4 * x(4) * x(6) * exp(2 * x(2) * x(6)) / (exp(2 * x(2) * x(6) + 1))^2 ...
  - 4 * x(5) * x(7) * exp(2 * x(2) * x(7)) / (1 + exp(2 * x(2) * x(7)))^2;
  
  H(3,3) = - x(2);
  
  H(3,4) = - (1 - 2/(1 + exp(2 * x(2) * x(6))));
  
  H(3,5) = - (1 - 2/(1 + exp(2 * x(2) * x(7))));
  
  H(3,6) = - 4 * x(4) * x(2) * exp(2 * x(6) * x(2)) / (1 + exp(2 * x(6) * x(2)))^2;
  
  H(3,7) = - 4 * x(4) * x(2) * exp(2 * x(7) * x(2)) / (1 + exp(2 * x(7) * x(2)))^2;
  
  K = P * H' * inv(H*P*H' + R);
  
  P = (eye(7) - K * H) * P;
  
  y = [q(t)];
  
  h = [x(1); x(2); (tau(t) - g_t(t) - x(3) * x(2) -x(4) * (1 - 2/(1 + exp(2 * x(2) * x(6)))) - x(5) * (1 - 2/(1 + exp(2 * x(2) * x(7)))))/ m(t)];
  
  x = x + K * (y(t,:)' - h);
  
  
end




theta = [Bv, Bf_1, Bf_2, w1, w2];
end

