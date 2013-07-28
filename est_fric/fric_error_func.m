function err = fric_error_func(x)
    global global_F_fric_s global_qp_s;
    est_fric = x(1).*global_qp_s + x(2).*(1 - 2./(1 + exp(2*x(4).*global_qp_s)))...
        + x(3).*(1 - 2./(1 + exp(2*x(5).*global_qp_s)));
    dif = global_F_fric_s - est_fric;
    err = dif'*dif;
end