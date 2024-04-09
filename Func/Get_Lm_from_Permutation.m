%Transform the logical matrix from the form of permutation matrix
%into the form of logical matix
function LM = Get_Lm_from_Permutation(L, M, N)
    LM = zeros(1, M*N);
    for i = 1:M*N
       for j = 1:N
           if L(j, i)==1
               LM(i) = j;
           end
       end
    end
end