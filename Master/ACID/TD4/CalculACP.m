function [ V , C ] = CalculACP( echantillon)
%CALCULACP Summary of this function goes here
%   Retourne la matrice trié des vecteur propre, et les echantillon
%   recentrés

moy = mean(echantillon);
C = echantillon - repmat(moy,size(echantillon, 1), 1);

S = (size(C,1)-1) * cov(C);

[e lambda] = eigs(S)
diagonal = diag(lambda)
[tri Itri] = sort(diagonal,'descend')

vtri = e;
for i = 1:length(lambda)
vtri(:,i) = e(:,Itri(i));
end

V = vtri
end

