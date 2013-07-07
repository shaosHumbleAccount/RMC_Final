clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
load 'C.mat'
load 'G.mat'

tau = M*qpp + C*qp + G;
numOfPara = 0;
expandedTau = expand(tau);
lengthOfTau = length(expandedTau);
Para = sym(zeros(20000,1));
for jointIdx = 1:lengthOfTau
    jointIdx
    terms = children(expandedTau(jointIdx));
    length(terms)
    for termIdx = 1:length(terms)
        para = sym('1');
        term = terms(termIdx);
        if  mod(termIdx,10) == 0
            disp(sprintf('%d of %d, joint %d',termIdx, length(terms),jointIdx ));
        end
        elems = children(term);
        lengthOfElems = length(elems);
        isValid = false;
        for elemIdx = 1:lengthOfElems
            elemAsStr = char(elems(elemIdx));
            if(isempty(strfind(elemAsStr,'q')) && (...
                    ~isempty(strfind(elemAsStr,'m')) ||...
                    ~isempty(strfind(elemAsStr,'l')) || ...
                    ~isempty(strfind(elemAsStr,'d')) || ...
                    ~isempty(strfind(elemAsStr,'I'))))
                para = para*elems(elemIdx);
                isValid = true;
            end
        end
        if(isValid)
            numOfPara = numOfPara + 1;
            Para(numOfPara) = para;
        end
    end
end
Para = Para(1:numOfPara,1);
save('Para.mat','Para')

for idx = 1:length(Para)
    idx
    paraAsStr{idx} = char(Para(idx));
end
save('paraAsStr.mat','paraAsStr')