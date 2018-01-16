function d = derivPolynome(coeff)
p = length(coeff);
puissance  = 0:p-1;
d = coeff .* puissance;
d(1) = [];
end