clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
load 'C.mat'
load 'G.mat'
load 'paraAsStr.mat'

%
% paraAsStr = cell(length(Para),1);
% for idx = 1:length(Para)
%     idx
%     paraAsStr{idx} = char(Para(idx));
% end
numOfPara = 0;
ParasStr(1) = paraAsStr(1);
for idx = 2:length(paraAsStr)
    hasSame = false;
    for j = 1:numOfPara
        if(strcmp(paraAsStr{idx},ParasStr{j}))
            hasSame = true;
            break;
        end
    end
    if(~hasSame)
        numOfPara = numOfPara + 1;
        ParasStr(numOfPara) =  paraAsStr(idx);
    end
end
Theta = sym(ParasStr);
numOfPara = length(Theta);

numOfElem = 0;
for idx = 1:numOfPara
    terms = children(Theta(idx));
    for termIdx = 1:length(terms)
        tmp1 = children(terms(termIdx));
        numOfElem = numOfElem + 1;
        elemTmp(numOfElem) = tmp1(1);
    end
end
uniqueElem(1) = elemTmp(1);
numOfUniqueElem = 1;
for idx = 2:numOfElem
    hasSame = false;
    for eleIdx = 1:numOfUniqueElem
        if(uniqueElem(eleIdx) == elemTmp(idx))
            hasSame = true;
            break;
        end
    end
    if(~hasSame)
        numOfUniqueElem = numOfUniqueElem + 1;
        uniqueElem(numOfUniqueElem) = elemTmp(idx);
    end
end

save('Theta.mat','ParasStr','Theta','numOfPara','uniqueElem','numOfUniqueElem')