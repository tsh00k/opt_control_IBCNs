%Input: 
%Stepping process cost cS, Jumping process cost cJ
%Stepping process transition matrix F, Jumping process transition matrix G
%Stepping process states index set S, Jumping process states index set J
%Zeno states set Z
%Number of states N, Number of input = M
%Output:
%Hybrid cost vector
function cH = Get_HybridCost(cS, cJ, F, G, S, J, Z, M, N)
    %The k-th power of G and its prefix sum
    G_power_prefix_sum = cell(1, N);
    G_power_prefix_sum{1} = G;
    for i = 2:N
        G_power_prefix_sum{i} = G_power_prefix_sum{i-1} + G^i;
    end
    I = eye(N);
    
    %The index set J\Z
    JnZ = [];
    for i = 1:length(J)
        if ~ismember(J(i), Z)
            JnZ(end+1) = J(i); %#ok<AGROW>
        end
    end
    
    cH = cS;
    for i = 1:M
        for j = 1:N
            if ~ismember(j, S)
                continue;
            end
            next = sp(sp(F, lm(i, M)), lm(j,N));
            next_idx = find(next(:) ~= 0);

            %disp(ismember(j, S));
            if ismember(next_idx, JnZ)
                for k = 1:N
                    T = G^k*F;
                    Jp = sp(sp(T, lm(i, M)), lm(j, N));
                    Jp_idx = find(Jp(:) ~= 0);
                    
                    if ismember(Jp_idx, S)
                       kij = k-1;
                       break;
                    end
                end
                
                if kij == 0
                    c = cS + cJ*F;
                else
                    c = cS + cJ*(I+G_power_prefix_sum{kij})*F;
                end
                cH((i-1)*N + j) = c((i-1)*N + j);
            end
        end
    end
end