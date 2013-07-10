Eand = ones(numOfPara);
for idx = 1:numOfJoint
    Eand = (Eand &  E{idx})
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

new_numOfTheta = curGroupID -1;
new_Theta = sym(zeros(new_numOfTheta,1))
new_Y =  sym(zeros(numOfJoint,new_numOfTheta))