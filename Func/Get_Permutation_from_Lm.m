function P = Get_Permutation_from_Lm(L, m, n)
    v = L.v;
    
    P = zeros(m, n);
    for i = 1:n
        P(v(i), i) = 1;
    end
end