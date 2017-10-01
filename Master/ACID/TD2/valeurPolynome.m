function v = valeurPolynome(coeff, x)
p = length(coeff);
puissance = 0:p-1;
v = zeros(1,length(x));
for i = 1:length(x)
    x2 = repmat(x(i),1,p);
    v(i) = sum(coeff.*(x2.^puissance));
end
end