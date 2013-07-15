function result = mycoeff( exp , term, order)
%MYCOEFF Summary of this function goes here
%   Detailed explanation goes here
if(order == 0)
    c = coeffs(expand(exp) + 0.01,term);
    if size(c,2) >= 1
        result = c(1) -  0.01;
    else
        result = sym(0);
    end
end
if(order == 1)
    c = coeffs(expand(exp)+ 0.01 + term,term);
    if size(c,2) >= 2
        result = c(2) - 1;
    else
        result = sym(0);
    end
end
if(order == 2)
    c = coeffs(expand(exp) + 0.01 + term + term.^2,term);
    if size(c,2) >= 3
        result = c(3) - 1;
    else
        result = sym(0);
    end
end
end

