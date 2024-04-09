%Calculate the largest invariant subset
%Input:
%State indices set M
%Structure matrix L
%Output:
%Matrix that can check which states in the largest invariant subset
function L_mat = Largest_Invar(M, L, dim)
    M_indi = Get_Indicator(M, dim);
    L_mat = (sp(L, M_indi)^length(M)) * M_indi;
end