%Get the k-domain cost function cK 
%Input:
%stepping process cost cS and jumping process cot J
%indices set of stepping process S and jumping process J
%Output:
%cK the k-domain cost function of hybrid domain
%cK the k-domain cost function of time domain (with jumping transition set to 0)
function [cK, cK_t] = Get_kLCS_Cost(cS, cJ, S, J, M, N)
    cA = Get_kLCS(cS, cJ, S, J, M, N);
    
    cK = cA;
    cK_t = cA;
    for i = 1:M
        for j = 1:N
            if ismember(j, J)
                cK_t((i-1)*N + j) = 0;
            end
        end
    end
end