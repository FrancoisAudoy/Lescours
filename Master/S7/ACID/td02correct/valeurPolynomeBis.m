function [ valeur ] = valeurPolynomeBis(x, coefs)
% calcule en x la valeur du polynome donné par son tableau de
% coefficients - puissances croissantes de gauche a droite
    
l = length(coefs);
puissance = [0:l-1];
tx = repmat(x,l,1) ;

valeur=coefs*(tx.^(puissance'));

end

