q_0 = [0.3; 0; 0; 0; 0; 0];
%q_0 = 0;
qp_0 = zeros(6,1);
qpp_0 = zeros(6,1);

q_t = zeros(6,1);
qp_t = zeros(6,1);
qpp_t = zeros(6,1);

%trajectory parameters
%A = [3,1,4,1,2,3];
%B = [1,2,1,2,3,5];
A = zeros(1,6);
B = zeros(1,6);
Wf = 1;


delta_t = 0.01; % in second
max_t = 2; % in second

t_s = 0 : delta_t : max_t;
q_s = zeros(length(t_s),6);
qp_s = zeros(length(t_s),6);
qpp_s = zeros(length(t_s),6);

desired_q_s = zeros(length(t_s),6);
desired_qp_s = zeros(length(t_s),6);

%[q_t qp_t] = trajectory_fourier(A, B, 0, Wf, q_0);%start at desired q(t = 0)

for t_idx = 1:length(t_s)
    t = t_s(t_idx);
    [desired_q, desired_qp] = trajectory_fourier(A, B, t, Wf, q_0);
    
    desired_q_s(t_idx,:) = desired_q;
    desired_qp_s(t_idx,:) = desired_qp;
    
    qpp_t = getqpp(q_t, qp_t, desired_q, desired_qp);
    qp_t = qp_t + qpp_t*delta_t;
    
    q_t = q_t + qp_t*delta_t;
    
    q_s(t_idx,:) = q_t;
    qp_s(t_idx,:) = qp_t;
    qpp_s(t_idx,:) = qpp_t;
    
    
end

figure
hold on
plot(q_s(:,1),'r')
plot(desired_q_s(:,1),'g')


