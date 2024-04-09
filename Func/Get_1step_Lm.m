%Get the one-step transition matrix from a structure matrix
function Ec = Get_1step_Lm(E, M, N)
    Ec = zeros(N, N);
    for j = 1:N:N*M
       Ec = Ec | E(:, j:j+N-1);
    end
end