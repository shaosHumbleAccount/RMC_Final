
q_0 = zeros(6,1);

qp_0 = zeros(6,1);

qpp_0 = zeros(6,1);

q_t = q_0;

qp_t = qp_0;

qpp_t = qpp_0;

delta_t = 0.001; % in second

max_t = 10; % in second

t_s = 0 : delta_t : max_t;
q_s = zeros(length(t_s),1);
qp_s = zeros(length(t_s),1);
qpp_s = zeros(length(t_s),1);

for t_idx = 1:length(t_s)
    
    t = t_s(t_idx);
    [desired_q, desired_qp] = trajectory(t);
    
    qpp_t = getqpp(q_t, qp_t, desired_q, desired_qp);
    
    qp_t = qp_t + qpp_t * delta_t;
    
    q_t = q_t + qp_t * delta_t;
    
    q_s(t_idx) = q_t;
    
    qp_s(t_idx) = qp_t;
    
    qpp_s(t_idx) = qpp_t;
    
    
end




