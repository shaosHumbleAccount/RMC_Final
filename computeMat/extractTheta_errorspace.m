clear all
clc
load 'def.mat'
load 'kinematic.mat'
load 'Jacobian.mat'
load 'M.mat'
load 'C.mat'
load 'G.mat'

tau = M*qppr + C*qpr + G;
numOfPara = 0;
expandedTau = expand(tau);
for jointIdx = 1:length(expandedTau)
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
        for elemIdx = 1:length(elems)
            elemAsStr = char(elems(elemIdx));
            if(isempty(strfind(elemAsStr,'q')) && (...
                    ~isempty(strfind(elemAsStr,'m')) ||...
                    ~isempty(strfind(elemAsStr,'l')) || ...
                    ~isempty(strfind(elemAsStr,'d')) || ...
                    ~isempty(strfind(elemAsStr,'I'))))
                para = para*elems(elemIdx);
            end
        end
        if(para ~= 1)
            hasSame = false;
%             for paraIdx = 1:numOfPara
%                 if(Para(paraIdx) == para)
%                     hasSame = true;
%                     break;
%                 end
%             end
            if(~hasSame)
                numOfPara = numOfPara + 1;
                Para_errorspace(numOfPara) = para;
            end
        end
    end
end

save('Para_errorspace.mat','Para_errorspace')