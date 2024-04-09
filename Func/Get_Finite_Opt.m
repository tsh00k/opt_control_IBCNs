%Input: cost vector c and cF
%structure matrix L
%perilous states set P
%number of control and states M,N
%a very large cost INF
%time considered T
%Output: Constructed iteration vector v
%state feedback control matrix K
function [v, K] = Get_Finite_Opt(c, cF, L, P, M, N, INF, T)
    %Reset the value of c to avoid perilous states
    for i = 1:M
        for j = 1:N
            col = L(:, (i-1)*N+j);
            idx = find(col(:) ~= 0);
            if ismember(idx, P)
               c((i-1)*N + j) = INF; 
            end
            if nnz(col)==0
                c((i-1)*N + j) = INF; 
            end
        end
    end
    
    v = cell(1, T);
    K = inf(T, N);
    v{T} = cF;
    t = T-1;
    
    while t>=1
        v{t} = inf(1, N);
        for i=1:M
             ci = sp(c, lm(i, M));
             Li = sp(L, lm(i, M));
             val = ci+v{t+1}*Li;
             for j=1:N
                 if(val(j) < v{t}(j))
                    v{t}(j) = val(j);
                    K(t, j) = i;
                 end
             end
        end
        t = t-1;
    end
end