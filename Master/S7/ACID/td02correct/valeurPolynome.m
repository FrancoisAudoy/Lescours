function [ valeur ] = valeurPolynome(x, coefs)
% calcule en x la valeur du polynome donné par son tableau de
% coefficients - puissances croissantes de gauche a droite
    
l = length(coefs);
puissance = [0:l-1];
tx = repmat(x,l,1) ;

for i=1:size(x,2)
      valeur(i)=sum((tx(:,i)'.^puissance).*coefs);
end

end

