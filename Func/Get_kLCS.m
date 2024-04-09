%Get the structure matrix of k-domain LCS
%Input:
%Sturcture matrix F(stepping process), G(jumping process)
%Indices set of stepping process S and jumping process J
%number of input M, number of states N
%Output:
%sturcture matrix of k-domain LCS E
function E = Get_kLCS(F, G, S, J, M, N)
    S_indi = Get_Indicator(S, N);
    J_indi = Get_Indicator(J, N);
    G_ = G*J_indi;
    for j = 1:N:M*N
        F_ = F(:, j:j+N-1);
        E(:, j:j+N-1) = F_*S_indi + G_;
    end
end