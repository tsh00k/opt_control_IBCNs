%Input: One step transition matrix Ec, 
%The complement of Zeno set Z_, 
%The dimension of Ec and Z_
%Output: Matrix used to check perilous set

function Pm = Get_PerilousMatrix(Ec, Z_, n)
    Z_M = Get_Indicator(Z_, n);
    Pm = Z_M * Ec^n;
end