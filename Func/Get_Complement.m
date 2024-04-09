%Get the complementary index set of Vec
function Comp = Get_Complement(Vec, n)
    Comp = zeros(1, n-length(Vec));
    idx = 0;
    for i = 1:n
        if ~ismember(i, Vec)
            idx = idx+1;
            Comp(idx)=i;
        end
    end
end