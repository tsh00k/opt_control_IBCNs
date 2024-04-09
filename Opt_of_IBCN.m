BIG = 1e6; %represent inf

N = 16;
M = 2;
F = Get_Bm([ 0 0 0 11 12 14 0 0 0 14 15 0 16 6  3  0 0 0 0 9  6  1  0 0 0 2  8  0 2  11 13 0], M, N);
G = Get_Bm([ 7   16  13 0 0 0 10 6 12 0 0 5 0 0 0 2], 1, N);
cS = [BIG BIG BIG 1 4 4 BIG BIG BIG 0 0 BIG 0 0 1 BIG BIG BIG BIG 4 1 0 BIG BIG BIG 0 3 BIG 1 5 0 BIG];
cJ = [4 0 0 BIG BIG BIG 5 6 2 BIG BIG 2 BIG BIG BIG 0];
cF = [BIG BIG BIG 2 1 0 BIG BIG BIG 1 3 BIG 4 2 3 BIG];

S = [4 5 6 10 11 13 14 15];
J = [1 2 3 7  8  9  12 16];

% Biological example: lambda switch
% BIG = 1e4; %represent inf
% 
% N = 32;
% M = 2;
% F = Get_Bm([32 24 32 24 32 24 32 24 26 2 26 2 25 9 25 9 32 24 32 24 32 24 32 24 28 4 32 8 27 11 31 15 32 24 32 24 32 24 32 24 32 8 32 8 31 15 31 15 32 24 32 24 32 24 32 24 32 8 32 8 31 15 31 15], M, N);
% G = Get_Bm([5 21 1 17 13 29 10 26 5 21 1 17 15 31 12 28 6 22 2 18 24 8 19 3 6 22 2 18 24 8 19 3], 1, N);
% cS = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1];
% cJ = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% cF = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% 
% S = [1 3 4 7 9 10 11 12 15 16 19 20 21 24 25 26 27 29 30 31 32];
% J = [2 5 6 8 13 14 17 18 22 23 28];

%----------------Above are the data of IBCN--------------------------
%----------------All of the function used are documented-------------

F_lm = Get_Lm_from_Permutation(F, M, N);

%Get the Zeno Set
Lar = Largest_Invar(J, G, N);
Z = Get_Set_from_Indi(Lar, N);
Z_ = Get_Complement(Z, N);

%Get the K-domain LCS
E = Get_kLCS(F, G, S, J, M, N);
E_lm = Get_Lm_from_Permutation(E, M, N);

%Get the Perilous Set
Ec = Get_1step_Lm(E, M, N);
Pm = Get_PerilousMatrix(Ec, Z_, N);
P = zeros(1, 1);
for i = 1:N
   if Pm(:, i) == 0
       P(end+1) = i; %#ok<SAGROW>
   end
end
P_ = Get_Complement(P, N);

%Get the Quotient Map and its Structure Matrix
Lz = Get_qMap(G, S, Z, N);
Lz_lm = Get_Lm_from_Permutation(Lz, 1, N);
LL = Lz*F;
LL_lm = Get_Lm_from_Permutation(LL, M, N);

%Get the Cost Function in Hybrid Domain
cH = Get_HybridCost(cS, cJ, F, G, S, J, Z, M, N);

%Get the Optimal Control under Finite Horizon
T = 6;
[v_tf, K_tf] = Get_Finite_Opt(cS, cF, LL, P, M, N, BIG, T);
[v_hf, K_hf] = Get_Finite_Opt(cH, cF, LL, P, M, N, BIG, T);

%Check the zero cost periodic circle (Only gets the states in circle)
[cK, cK_t] = Get_kLCS_Cost(cS, cJ, S, J, M, N);
[E0t, R0t] = Check_Zero_Circle(cK_t, E, Z, M, N);
[E0h, R0h] = Check_Zero_Circle(cK, E, Z, M, N);

%Get the Optimal Control under Infinite Horizon
[v_tinf, K_tinf] = Get_Infinite_Opt(cS, LL, P, M, N, BIG, 100);
[v_hinf, K_hinf] = Get_Infinite_Opt(cH, LL, P, M, N, BIG, 100);








