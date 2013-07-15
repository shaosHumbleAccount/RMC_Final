numOfPara = size(Yr_norm,2);
numOfJoint = size(Yr_norm,1);

Eand = ones(numOfPara);
for idx = 1:numOfJoint
    Eand = (Eand &  E{idx});
end


group = zeros(numOfPara,1);
curGroupID = 1;
for idx = 1:numOfPara
    if group(idx) == 0
        group(idx) = curGroupID;%new group
        curGroupID = curGroupID + 1;
    end
    for idx2 = idx:numOfPara
        if(Eand(idx,idx2) == 1)
            group(idx2) = group(idx);
        end
    end
end

simp_numOfTheta = curGroupID -1;
simp_Theta = sym(zeros(simp_numOfTheta,1));
simp_Y =  sym(zeros(numOfJoint, simp_numOfTheta));
for groupID = 1:simp_numOfTheta
    for idx = 1:numOfPara
        if group(idx) == groupID
            simp_Theta(groupID) = simp_Theta(groupID) + Theta(idx);
            for jointIdx = 1:numOfJoint
                simp_Y(jointIdx,groupID) = Yr_norm(jointIdx,idx);
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