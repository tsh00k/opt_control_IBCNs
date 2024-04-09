%Return [i for Ind(i, i) ~= 0]
function S = Get_Set_from_Indi(Ind, n)
    idx = 0;
    S = []
    for i = 1:n
        if Ind(i, i) == 1
            idx = idx+1;
            S(idx) = i; %#ok<AGROW>
        end
    end
end