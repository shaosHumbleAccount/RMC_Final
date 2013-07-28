numOfPara = size(Yr_norm,2);
numOfJoint = size(Yr_norm,1);

Eand = E{1};
for idx = 2:numOfJoint
    curE = E{idx};
    for row = 1:numOfPara
        for col = 1:numOfPara
            if Eand(row,col) == 0
            elseif Eand(row,col) == 9999
                Eand(row,col) = curE(row,col);
            elseif curE(row,col) == 9999
            elseif Eand(row,col) ~= curE(row,col)
                Eand(row,col) = 0;
            end
        end
    end
end
Eand(Eand == 9999) = 1;

group = zeros(numOfPara,1);
curGroupID = 1;
for idx = 1:numOfPara
    if group(idx) == 0
        group(idx) = curGroupID;%new group
        curGroupID = curGroupID + 1;
    end
    for idx2 = idx:numOfPara
        if Eand(idx,idx2) == 1
            group(idx2) = group(idx);
        elseif Eand(idx,idx2) == -1
            group(idx2) = -group(idx);
        end
    end
end

simp_numOfTheta = curGroupID -1;
simp_Theta = sym(zeros(simp_numOfTheta,1));
simp_Y =  sym(zeros(numOfJoint, simp_numOfTheta));
for groupID = 1:simp_numOfTheta
    for idx = 1:numOfPara
        if abs(group(idx)) == groupID
            if group(idx) == groupID
                simp_Theta(groupID) = simp_Theta(groupID) + Theta(idx);
            elseif group(idx) == -groupID
                simp_Theta(groupID) = simp_Theta(groupID) - Theta(idx);
            end
            for jointIdx = 1:numOfJoint
                simp_Y(jointIdx,groupID) = sign(group(idx))*Yr_norm(jointIdx,idx);
            end
        end
    end
end
Yr = simp_Y;
Theta = simp_Theta;
save('min_Y_Theta.mat','Yr','Theta');

id = fopen('min_Theta.txt','w');
for row = 1:simp_numOfTheta
    s = sprintf('Theta(%d,%d) = %s;\n',row,1,char(Theta(row)));
    fprintf(id,s);
end
fclose(id);

id = fopen('min_Yr_norm.txt','w');
for row = 1:numOfJoint
    for col = 1:simp_numOfTheta
        s = sprintf('Yr_norm(%d,%d) = %s;\n',row,col,char(Yr(row,col)));
        fprintf(id,s);
    end
end
fclose(id);