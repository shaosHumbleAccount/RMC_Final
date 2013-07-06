function [desired_q, desired_qp] = trajectory_fourier( A, B, desired_t, Wf, q_0)
numOfJoint = length(q_0);

desired_q = zeros(numOfJoint,1);
desired_qp = zeros(numOfJoint,1);
N = size(A,1);

for idx = 1: numOfJoint
    desired_q(idx) = q_0(idx);
    
    for l = 1: N
        desired_q(idx) = desired_q(idx) +  A(l,idx) * sin(l * Wf * desired_t) / (l * Wf)...
            - B(l,idx) * cos(l * Wf * desired_t) / (l * Wf);
        
        desired_qp(idx) = desired_qp(idx) + A(l,idx) * cos(l * Wf*desired_t) + ...
            B(l,idx)*sin(l*Wf*desired_t);
    end
end

