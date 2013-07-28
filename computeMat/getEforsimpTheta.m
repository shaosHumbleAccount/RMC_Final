%function [ theta_simp ] = simplifytheta( Yr )
%SIMPLIFYTHETA Summary of this function goes here
%   Detailed explanation goes here
Yr = Yr_norm;
numOfPara = size(Yr,2);

numOfJoint = size(Yr,1);

NumOfChildren = zeros(numOfJoint,numOfPara);
for idx_joint = 1: numOfJoint
    for idx_para = 1: numOfPara
        NumOfChildren(idx_joint,idx_para) = length(children(Yr(idx_joint,idx_para) + 8888)) - 1;
    end
end

for idx_joint = 1: numOfJoint
    E_temp = 9999*ones(numOfPara) - 9998*eye(numOfPara);
    for idx_para = 1: (numOfPara - 1)
        fprintf('joint %d, para %d\n',idx_joint,idx_para);
        for k = idx_para + 1: numOfPara
            pre_flag = false;
            if idx_joint > 1
                for pre_joint = 1:(idx_joint - 1)
                    pre_E = E{pre_joint};
                    if pre_E(idx_para, k) == 0
                        E_temp(idx_para, k) = 0;
                        E_temp(k, idx_para) = 0;
                        pre_flag = true;
                        break;
                    end
                end
            end
            if ~pre_flag
                if NumOfChildren(idx_joint,idx_para) ~= NumOfChildren(idx_joint,k)
                    E_temp(idx_para, k) = 0;
                    E_temp(k, idx_para) = 0;
                else
                    if simplify (Yr(idx_joint,idx_para) - Yr(idx_joint, k)) == 0
                        if Yr(idx_joint,idx_para) == 0
                            E_temp(idx_para, k) = 9999;
                            E_temp(k, idx_para) = 9999;
                        else
                            E_temp(idx_para, k) = 1;
                            E_temp(k, idx_para) = 1;
                        end
                    elseif simplify (Yr(idx_joint,idx_para) + Yr(idx_joint, k)) == 0
                        if Yr(idx_joint,idx_para) == 0
                            E_temp(idx_para, k) = 9999;
                            E_temp(k, idx_para) = 9999;
                        else
                            E_temp(idx_para, k) = -1;
                            E_temp(k, idx_para) = -1;
                        end
                    else
                        E_temp(idx_para, k) = 0;
                        E_temp(k, idx_para) = 0;
                    end
                end
            end
        end
        E(idx_joint) = { E_temp};
    end
end

