clear all
q_0 = 0;

A = [3;1;4];

B = [1;2;1];

Wf = 1;

delta_t = 0.001; % in second

max_t = 10; % in second

t_s = 0 : delta_t : max_t;

desired_q_s = zeros(length(t_s),1);
desired_qp_s = zeros(length(t_s),1);

for t_idx = 1:length(t_s)
    
    t = t_s(t_idx);
    [desired_q, desired_qp] = trajectory_fourier(A, B, t, Wf, q_0);
    
    desired_q_s(t_idx) = desired_q;
    desired_qp_s(t_idx) = desired_qp;
    
end
figure
plot(desired_q_s)


NFFT = 2^nextpow2(length(t_s)); % Next power of 2 from length of y
Y = fft(desired_q_s,NFFT)/length(t_s);
f = (1-delta_t)/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')