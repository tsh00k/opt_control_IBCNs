%Input: Jumping process transition matrix G
%Steping process index set S
%Zeno states index set Z
%The dimension of G
%Output: Quotient mapping matrix Lz
function Lz = Get_qMap(G, S, Z, dim)    
    psi = zeros(1, dim);
    for col = 1:dim
        if ismember(col, Z) || ismember(col, S)
            continue;
        end
        
        for k = 1:dim-1
            Trans = G^k;
            Trans_idx = find(Trans(:, col) ~= 0);
            if ismember(Trans_idx, S)
                psi(col) = k;
                break;
            end
        end
    end
    
    I = eye(dim);
    
    Lz = zeros(dim, dim);
    for col = 1:dim
        if ismember(col, Z)
            continue;
        end
        
        if psi(col) == 0
            Lz(:, col) = I(:, col);
        else
            Gp = G^psi(col);
            Lz(:, col) = Gp(:, col);
        end
     end
end