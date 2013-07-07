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

tau = M*qppr + C*qpr + G;

Yr_errorspace = sym(zeros(numOfJoint,numOfPara));
for jointIdx = 1:numOfJoint
    jointIdx
    for paraIdx = 1:numOfPara
        tic
        paraIdx
        tmp = tau(jointIdx);
        chd = children(Theta(paraIdx));
        numOfChildren = length(chd);
        sumOfOrder = 0;
        
        for tIdx = 1:numOfChildren
            tE = children(chd(tIdx));
            sumOfOrder = sumOfOrder + diff(log(Theta(paraIdx)), tE(1))*tE(1);
        end
        for elemIdx = 1:numOfChildren
            tE = children(chd(elemIdx));
            tmp = mycoeff( tmp , tE(1), ...
                diff(log(Theta(paraIdx)), tE(1))*tE(1));
        end
        tmp
        %eliminate false match
        if sumOfOrder == 2
            for elemIdx = 1:numOfUniqueElem
                elemAsStr = char(uniqueElem(elemIdx));
                if(isempty(strfind(elemAsStr,'I')) && ...
                        isempty(strfind(elemAsStr,'m')) && (...
                        ~isempty(strfind(elemAsStr,'d')) ||...
                        ~isempty(strfind(elemAsStr,'l'))))
                    tmpOrder = diff(log(Theta(paraIdx)), uniqueElem(elemIdx))*uniqueElem(elemIdx);
                    if tmpOrder == 0
                        tmp = mycoeff( tmp , uniqueElem(elemIdx), tmpOrder);
                    end
                end
            end
        end
        tmp
        toc
        Yr_errorspace(jointIdx,paraIdx) = tmp;
    end
end

id = fopen('Yr_errorspace.txt','w');
for row = 1:numOfJoint
    for col = 1:numOfPara
        s = sprintf('Yr_errorspace(%d,%d) = %s;\n',row,col,char(Yr_errorspace(row,col)));
        fprintf(id,s);
    end
end
fclose(id);

disp('****************************************')

tau = M*qpp + C*qp + G;
Yr_norm = sym(zeros(numOfJoint,numOfPara));
for jointIdx = 1:numOfJoint
    jointIdx
    for paraIdx = 1:numOfPara
        tic
        paraIdx
        tmp = tau(jointIdx);
        chd = children(Theta(paraIdx));
        numOfChildren = length(chd);
        sumOfOrder = 0;
        for tIdx = 1:numOfChildren
            tE = children(chd(tIdx));
            sumOfOrder = sumOfOrder + diff(log(Theta(paraIdx)), tE(1))*tE(1);
        end
        for elemIdx = 1:numOfChildren
            tE = children(chd(elemIdx));
            tmp = mycoeff( tmp , tE(1), ...
                diff(log(Theta(paraIdx)), tE(1))*tE(1));
        end
        tmp
        if sumOfOrder == 2
            for elemIdx = 1:numOfUniqueElem
                elemAsStr = char(uniqueElem(elemIdx));
                if(isempty(strfind(elemAsStr,'I')) && ...
                        isempty(strfind(elemAsStr,'m')) && (...
                        ~isempty(strfind(elemAsStr,'d')) ||...
                        ~isempty(strfind(elemAsStr,'l'))))
                    tmpOrder = diff(log(Theta(paraIdx)), uniqueElem(elemIdx))*uniqueElem(elemIdx);
                    uniqueElem(elemIdx);
                    if tmpOrder == 0
                        tmp = mycoeff( tmp , uniqueElem(elemIdx), tmpOrder);
                    end
                end
            end
        end
        tmp
        toc
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

save('Yr.mat','Yr_errorspace','Yr_norm')