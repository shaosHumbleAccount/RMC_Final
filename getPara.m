clear all
clc
load 'paraAsStr.mat'
%
% paraAsStr = cell(length(Para),1);
% for idx = 1:length(Para)
%     idx
%     paraAsStr{idx} = char(Para(idx));
% end
numOfPara = 0;
Paras(1) = paraAsStr(1);
for idx = 2:length(paraAsStr)
    hasSame = false;
    for j = 1:numOfPara
        if(strcmp(paraAsStr{idx},Paras{j}))
            hasSame = true;
            break;
        end
    end
    if(~hasSame)
        numOfPara = numOfPara + 1;
        Paras(numOfPara) =  paraAsStr(idx);
    end
end

save('Theta','Paras')