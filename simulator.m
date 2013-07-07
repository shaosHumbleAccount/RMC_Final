clc
clear all
q_0 = [0; pi/2; pi; 0 ; pi; 0];
qp_0 = zeros(6,1);
qpp_0 = zeros(6,1);

q_t = [0; pi/2-0.3 ;pi; 0 ; pi; 0];
%q_t(3) = pi/3;
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

Tau_s = zeros(length(t_s),6);

%[q_t qp_t] = trajectory_fourier(A, B, 0, Wf, q_0);%start at desired q(t = 0)

for t_idx = 1:length(t_s)
    
    t = t_s(t_idx);
    [desired_q, desired_qp] = trajectory_fourier(A, B, t, Wf, q_0);
    
    %[desired_q_tmp, desired_qp_tmp] = trajectory_fourier(A, B, t + delta_t, Wf, q_0);
    
    desired_q_s(t_idx,:) = desired_q;
    desired_qp_s(t_idx,:) = desired_qp;
    
    qp_t = qp_t + qpp_t.*delta_t;
    q_t = q_t + qp_t.*delta_t;
    for jid = 1:6
        if(q_t(jid) > pi)
            q_t(jid) = mod(q_t(jid),-pi);
        end
        if(q_t(jid) < -pi)
            q_t(jid) = mod(q_t(jid),pi);
        end
    end
    
    tic
    [qpp_t Tau]= getqpp(q_t, qp_t, desired_q, desired_qp,zeros(6,1));
    
    qpp_t(1) = 0;
    qpp_t(3) = 0;
    qpp_t(4) = 0;
    qpp_t(5) = 0;
    qpp_t(6) = 0;
    toc
    
    q_s(t_idx,:) = q_t;
    qp_s(t_idx,:) = qp_t;
    qpp_s(t_idx,:) = qpp_t;
    Tau_s(t_idx,:) = Tau;
    
end

figure
hold on
plot(q_s(:,1),'r')
plot(q_s(:,2:end))
legend('1','2','3','4','5','6')
plot(desired_q_s(:,:),'g')
ylim([-pi pi])
hold off

