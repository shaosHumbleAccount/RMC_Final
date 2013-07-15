
tau = M*qppr + C*qpr + G;

Yr_errorspace = sym(zeros(numOfJoint,numOfPara));
for jointIdx = 1:numOfJoint
    for paraIdx = 1:numOfPara
        tic
        fprintf('joint %d para %d ',jointIdx,paraIdx);
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
        %eliminate false match
        if sumOfOrder == 2
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
        end
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
        fprintf('Yr_errorspace(%d,%d) = %s\n',jointIdx,paraIdx,char(tmp));
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

save('Yr_errorspace.mat','Yr_errorspace')



