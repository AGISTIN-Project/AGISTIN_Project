function [dFF] = dFF_delete(maskarray,dFF)
%dFF_delete erases entries from matrix parameterrun.dFF
%mask value 0 means: ignore value in this place
%mask value >0 means: this place must have exactly this value, together
%with all other mask values > 0
    if size(dFF,2) == 7 && size(maskarray,2) == 7 && size(maskarray,1) > 0
        for k1 = 1:size(maskarray,1)
            cmparray = dFF;
            for k2 = 1:size(maskarray,2)
                if maskarray(k1,k2) == 0
                    cmparray(:,k2) = 0;
                else
                    for k3 = 1:size(cmparray,1)
                        if maskarray(k1,k2) == cmparray(k3,k2)
                            cmparray(k3,k2) = 0;
                        end
                    end
                end
            end
            di = ismember(cmparray,[0 0 0 0 0 0 0], 'rows');
            for k3 = size(cmparray,1):-1:1
                if di(k3) == 1
                    dFF(k3,:) = [];
                end    
            end
        end
    end
end

