global global_F_fric_s global_qp_s;
[sorted_qp_s,IX]  = sort(qp_s(:,1));
sorted_Fric = F_fric_s(IX,1);
chosen = zeros(length(qp_s),1);
chosen(1) = 1;
curQp = sorted_qp_s(1);
for idx = 2:length(qp_s)
    if sorted_qp_s(idx) >= curQp + 0.001
        chosen(idx) = 1;
        curQp = sorted_qp_s(idx);
    end
end
global_F_fric_s = sorted_Fric(chosen > 0);
global_qp_s = sorted_qp_s(chosen > 0);

est_x = fmincon( @fric_error_func, [0.1;0.25;0.25;0.9;1.2] ,...
     zeros(5),zeros(5,1),zeros(5),zeros(5,1),...
     [0; 0; 0; 0; 0],[1 ;0.5; 0.5; 2; 2]);
 est_x