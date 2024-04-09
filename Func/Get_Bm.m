%Transform the matrix from logical matrix form into the permutation matrix form(can has 0 value col)
function Bm = Get_Bm(vec, M, N)
   I = eye(N);
   Bm = zeros(N, M*N);
   for i = 1:M*N
       if vec(i) ~= 0
            Bm(:, i) = I(:, vec(i));
       else
            Bm(:, i) = 0;
       end
   end
end