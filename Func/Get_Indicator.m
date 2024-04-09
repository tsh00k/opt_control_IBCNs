function Indi = Get_Indicator(set, dim)
    Indi = eye(dim); 
    
    for i = 1:dim
       isIn = ismember(i,set);
       if ~isIn
            Indi(:,i) = 0;
       end
    end
end