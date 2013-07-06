clear all
clc
load 'def.mat'
load 'kinamtic.mat'
load 'Jacobian.mat'
load 'M.mat'
load 'C.mat'
load 'G.mat'

tau = M*qppr + C*qpr + G;
numOfPara = 0;
expandedTau = expand(tau);
for jointIdx = 1:length(expandedTau)
    terms = children(expandedTau(jointIdx));
    for termIdx = 1:length(terms)
        para = sym('1');
        term = terms(termIdx);
        elems = children(term);
        for elemIdx = 1:length(elems)
            elemAsStr = char(elems(elemIdx));
            if(isempty(strfind(elemAsStr,'q')) && (...
                    ~isempty(strfind(elemAsStr,'m')) ||...
                    ~isempty(strfind(elemAsStr,'l')) || ...
                    ~isempty(strfind(elemAsStr,'I'))))
                para = para*elems(elemIdx);
            end
        end
        if(para ~= 1)
            hasSame = false;
            for paraIdx = 1:numOfPara
                if(Para(paraIdx) == para)
                    hasSame = true;
                    break;
                end
            end
            if(~hasSame)
                numOfPara = numOfPara + 1;
                Para(numOfPara) = para;
            end
        end
    end
end