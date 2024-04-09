%Input:
%cost vector c
%structure matrix E
%zeno states indices set Z
%number of input M, number of states N
%Output:
%E0: one-step zero cost transition matrix (not including zeno states)
%R0: a vector with length = N, if R0(i)=1 then state Delta^i is on a zero
%cost circle

function [E0, R0] = Check_Zero_Circle(c, E, Z, M, N)
    C = zeros(N, N*M);
    I = eye(N);
    for i = 1:M
        for j = 1:N
            if c((i-1)*N + j)==0 && ~ismember(j, Z)
               C(:, (i-1)*N + j) = I(:, j);
            end
        end
    end
    
    E0 = zeros(N, N);
    for j = 1:N:N*M
       E0 = E0 | E(:, j:j+N-1)*C(:, j:j+N-1);
    end
    
    R0 = zeros(1, N);
    for i = 1:N
        E0p = E0^i;
        for j = 1:N
            if E0p(j, j) ~= 0 && ~ismember(j, R0)
                R0(j) = 1;
            end
        end
    end
end