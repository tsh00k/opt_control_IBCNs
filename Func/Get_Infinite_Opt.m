%Input: cost vector c
%structure matrix L
%perilous states set P
%number of control and states M,N
%a very large cost INF
%a max iteration limit Max_iter
%Output: Constructed iteration vector v
%state feedback control matrix K

function [v, K] = Get_Infinite_Opt(c, L, P, M, N, INF, Max_iter)
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
    
    in_plateu = 0;
    iter = 1;
    v{iter} = zeros(1, N);
    K = zeros(1, N);
    
    while in_plateu<N && iter<Max_iter
        iter=iter+1;
        v{iter} = Inf(1, N);
        for i=1:1:M
             ci = sp(c, lm(i, M));
             Li = sp(L, lm(i, M));
             val = ci+v{iter-1}*Li;
             for j=1:1:N
                 if(val(j) < v{iter}(j))
                    v{iter}(j)=val(j);
                    K(j) = i;
                 end
             end
        end

        if all(v{iter}(:) == v{iter-1}(:))
            in_plateu = in_plateu+1;
        else
            in_plateu = 0;
        end
    end
end
