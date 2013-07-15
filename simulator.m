clc
clear all
q_0 = [0; 0;0;0;0; 0];
qp_0 = zeros(6,1);
qpp_0 = zeros(6,1);

q_t = [0; 0;0;0;0; 0];
%q_t(3) = pi/3;
qp_t = zeros(6,1);
qpp_t = zeros(6,1);

%trajectory parameters
A = [0.8, 1.2, 0.8, 0.7, -0.4, 0.4
    1 0.2 0.5 -2 1 0.5
    0.8, 1.2, 0.8, 0.7, -0.4, 0.4];
B = [-0.5, 0.5,-1.5, 1.4, 1,0.2
    -1 -3 -2 0.3 -1 1.2
    0.8, 1.2, 0.8, 0.7, -0.4, 1.4];
%A = zeros(1,6);
%B = zeros(1,6);
Wf = 2;


delta_t = 0.01; % in second
max_t = 5; % in second

t_s = 0 : delta_t : max_t;
q_s = zeros(length(t_s),6);
qp_s = zeros(length(t_s),6);
qpp_s = zeros(length(t_s),6);

desired_q_s = zeros(length(t_s),6);
desired_qp_s = zeros(length(t_s),6);

Tau_s = zeros(length(t_s),6);
M_part_s  = zeros(length(t_s),6);
F_fric_s  = zeros(length(t_s),6);
G_part_s = zeros(length(t_s),6);
[q_t, qp_t, qpp_t] = trajectory_fourier(A, B, 0, Wf, q_0);%start at desired q(t = 0)

last_qp = 0;
last_qpp = 0;
last2_qpp = 0;

F = zeros(6*length(t_s),46);
b = zeros(6*length(t_s),1);

q_0 = [0; pi/2; 0; 0; 0; 0];
qp_0 = zeros(6,1);
qpp_0 = zeros(6,1);
q_t = [0; pi/2; 0; 0; 0; 0];
%socket = tcpip('localhost',11235);
%fopen(socket);
for t_idx = 1:length(t_s)
    
    tic
    t = t_s(t_idx);
    [desired_q, desired_qp,desired_qpp] = trajectory_fourier(A, B, t, Wf, q_0);
    
    %[desired_q_tmp, desired_qp_tmp] = trajectory_fourier(A, B, t + delta_t, Wf, q_0);
    
    desired_q_s(t_idx,:) = desired_q;
    desired_qp_s(t_idx,:) = desired_qp;
    
    last_qp = qp_t;
    last_qpp =  qpp_t;
    
    if t_idx > 2
        last2_qpp = qpp_s(t_idx - 2);
    end
    
    qp_t = qp_t + (last_qpp + qpp_t)/2.*delta_t;
    q_t = q_t + (qp_t + last_qp)/2.*delta_t;
    
    for jid = 1:6
        if(q_t(jid) > pi)
            q_t(jid) = mod(q_t(jid),-pi);
        end
        if(q_t(jid) < -pi)
            q_t(jid) = mod(q_t(jid),pi);
        end
    end
    [qpp_t, Tau, M_part, G_part, F_fric, Yr]= getqpp(q_t, qp_t, desired_q, desired_qp, desired_qpp);
  
  
    %qpp_t(1) = 0;
    %qpp_t(2) = 0;
    %qpp_t(3) = 0;
    %qpp_t(4) = 0;
    %qpp_t(5) = 0;
    %qpp_t(6) = 0;
    toc
    
    q_s(t_idx,:) = q_t;
    qp_s(t_idx,:) = qp_t;
    qpp_s(t_idx,:) = qpp_t;
    Tau_s(t_idx,:) = Tau;
    M_part_s(t_idx,:) = M_part;
    F_fric_s(t_idx,:) = F_fric;
    G_part_s(t_idx,:) = G_part;
    
    F((6*(t_idx-1)+1):(6*(t_idx)),:) = Yr;
    b((6*(t_idx-1)+1):(6*(t_idx)),1) = Tau;
    
    
    %[m,errmsg]=sprintf('2 0 %f %f %f %f %f %f',q_t(1),...
       % q_t(2),q_t(3),q_t(4),q_t(5),q_t(6));
    %fprintf(socket, m);
end

figure
hold on
plot(q_s(:,1),'r')
plot(q_s(:,2:end))
legend('1','2','3','4','5','6')
plot(desired_q_s(:,:),'g')
ylim([-pi pi])
hold off

(F'*F)\(F'*b)

