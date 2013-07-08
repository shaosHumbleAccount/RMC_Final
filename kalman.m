function [ theta x_s] = kalman( q, qp, qpp, tau, m, g_t, diff_g_x1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sym m ;

N = length(q);

P = diag([0.001 0.001 0.1 0 0 0 0]);

K = zeros(7,3);

x = [q(1) qp(1) 1 0 0 0 0]';

y = [q qp qpp];

R = 0.01*eye(3,3);

x_s = zeros(N,7);
x_s(1,:) = x;
for t = 2: N
  %symQ  = q(t);
  
  H = zeros(3,7);
  
  H(1,1) = 1;
  H(2,2) = 1;
  H(3,1) = 0;%eval(-diff_g_x1);%FIXME
  
  H(3,2) = (-x(3) - 4  * x(4) * x(6) * exp(2 * x(2) * x(6)) / (1 + exp(2 * x(2) * x(6)) )^2 ...%FIXME
  - 4 * x(5) * x(7) * exp(2 * x(2) * x(7)) / (1 + exp(2 * x(2) * x(7)))^2 )./m(t);
  
  H(3,3) = - x(2)./m(t);
  
  H(3,4) = - (1 - 2/(1 + exp(2 * x(2) * x(6))))./m(t);
  
  H(3,5) = - (1 - 2/(1 + exp(2 * x(2) * x(7))))./m(t);
  
  H(3,6) = - (4  * x(4)* x(2) * exp(2 * x(6) * x(2)) / (1 + exp(2 * x(6) * x(2)))^2)./m(t);
  
  H(3,7) = - (4  * x(5)* x(2) * exp(2 * x(7) * x(2)) / (1 + exp(2 * x(7) * x(2)))^2)./m(t);

%   if(rank(H*P*H' + R) ~= 3)
%     disp('!')
%   end
  K = P * H' * (inv(H*P*H' + R));
  
  P = (eye(7) - K * H) * P;
 
  h = [x(1)+x(2); x(2)+tau(t-1)./m(t); ...
      (tau(t) - g_t(t) - ...
      x(3) * x(2) -x(4) * (1 - 2/(1 + exp(2 * x(2) * x(6)))) - x(5) * (1 - 2/(1 + exp(2 * x(2) * x(7)))))./ m(t)];
  
  x = x + K * (y(t,:)' - h);
  
  x_s(t,:) = x;
end
Bv = x(3);
Bf_1 = x(4);
Bf_2 = x(5);
w1 = x(6);
w2 = x(7);
theta = [Bv, Bf_1, Bf_2, w1, w2];
end

