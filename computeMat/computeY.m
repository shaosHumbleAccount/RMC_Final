clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
load 'C.mat'
load 'G.mat'
load 'paraAsStr.mat'
load Theta
disp('****************************************')

tau = M*qpp + C*qp + G;
Yr_norm = sym(zeros(numOfJoint,numOfPara));
for jointIdx = 1:numOfJoint
    for paraIdx = 1:numOfPara
        tic
        fprintf('computing Yr_norm joint %d para %d ',jointIdx,paraIdx);
        tmp = tau(jointIdx);
        chd = children(Theta(paraIdx));
        numOfChildren = length(chd);
        %         sumOfOrder = 0;
        %         for tIdx = 1:numOfChildren
        %             tE = children(chd(tIdx));
        %             sumOfOrder = sumOfOrder + diff(log(Theta(paraIdx)), tE(1))*tE(1);
        %         end
        for elemIdx = 1:numOfChildren
            tE = children(chd(elemIdx));
            tmp = mycoeff( tmp , tE(1), ...
                diff(log(Theta(paraIdx)), tE(1))*tE(1));
        end
        %eliminate false match
        %         if sumOfOrder == 2
        tmp_ch = children(expand(tmp));
        num_tmp = length(tmp_ch);
        for tmp_idx = 1:num_tmp
            if(~isempty(strfind(char(tmp_ch(tmp_idx)),'I')) ||...
                    ~isempty(strfind(char(tmp_ch(tmp_idx)),'m'))||...
                    ~isempty(strfind(char(tmp_ch(tmp_idx)),'d'))||...
                    ~isempty(strfind(char(tmp_ch(tmp_idx)),'l')))
                tmp = tmp - tmp_ch(tmp_idx);
            end
        end
        %end
        %         if sumOfOrder == 2
        %             for elemIdx = 1:numOfUniqueElem
        %                 elemAsStr = char(uniqueElem(elemIdx));
        %                 if(isempty(strfind(elemAsStr,'I')) && ...
        %                         isempty(strfind(elemAsStr,'m')) && (...
        %                         ~isempty(strfind(elemAsStr,'d')) ||...
        %                         ~isempty(strfind(elemAsStr,'l'))))
        %                     tmpOrder = diff(log(Theta(paraIdx)), uniqueElem(elemIdx))*uniqueElem(elemIdx);
        %                     if tmpOrder == 0
        %                         tmp = mycoeff( tmp , uniqueElem(elemIdx), tmpOrder);
        %                     end
        %                 end
        %             end
        %         end
        toc
        fprintf('Yr_norm(%d,%d) = %s\n',jointIdx,paraIdx,char(tmp));
        Yr_norm(jointIdx,paraIdx) = tmp;
    end
end

id = fopen('Yr_norm.txt','w');
for row = 1:numOfJoint
    for col = 1:numOfPara
        s = sprintf('Yr_norm(%d,%d) = %s;\n',row,col,char(Yr_norm(row,col)));
        fprintf(id,s);
    end
end
fclose(id);

save('Yr_norm.mat','Yr_norm')
disp('*****************Verify Y*Theta = Tau. The following vector should only contain 0s. ***********************')
syms I111 I112 I113 I122 I123 I133 real;
syms I211 I212 I213 I222 I223 I233 real;
syms I311 I312 I313 I322 I323 I333 real;

syms I411 I412 I413 I422 I423 I433 real;
syms I511 I512 I513 I522 I523 I533 real;
syms I611 I612 I613 I622 I623 I633 real;
syms q1 q2 q3 q4 q5 q6 real;
syms qp1 qp2 qp3 qp4 qp5 qp6 real;
syms qpp1 qpp2 qpp3 qpp4 qpp5 qpp6 real
syms l1 l2 l3 l4 l5 l6 real;
syms d1 d2 d4 d7 d8 d9 d10 real; 
syms m1 m2 m3 m4 m5 m6 real;
simplify(Yr_norm*Theta' - tau)

