%function [ theta_simp ] = simplifytheta( Yr )
%SIMPLIFYTHETA Summary of this function goes here
%   Detailed explanation goes here

numOfPara = size(Yr,2);

numOfJoint = size(Yr,1);

NumOfChildren = zeros(idx_joint,numOfPara);
for idx_joint = 1: numOfJoint
    for idx_para = 1: numOfPara
        NumOfChildren(idx_joint,idx_para) = length(children(Yr(idx_joint,idx_para)));
    end
end

for (idx_joint = 1: numOfJoint)
    idx_joint
    E_temp = eye(numOfPara);
    for (idx_para = 1: numOfPara - 1)
        idx_para
        for (k = idx_para : numOfPara)
            if NumOfChildren(idx_joint,idx_para) ~= NumOfChildren(idx_joint,k)
                E_temp(idx_para, k) = 0;
                E_temp(k, idx_para) = 0;
            else
                if(simplify (Yr(idx_joint,idx_para) - Yr(idx_joint, k)) == 0)
                    E_temp(idx_para, k) = 1;
                    E_temp(k, idx_para) = 1;
                end
            end
        end
        E(idx_joint) = { E_temp};
    end
    
end

