function [poly_without_constant] = removeConstant(poly_with_constant)
%REMOVECONSTANT removes constant term (i.e. independet of indets)
%   Detailed explanation goes here

[indet,power,M] = decomp(poly_with_constant);

for k=1:size(power,1)
    if sum(power(k,:)) == 0
        M(:,k) = zeros(size(M,1),1);
    end
end

poly_without_constant = recomp(indet,power,M);

end

