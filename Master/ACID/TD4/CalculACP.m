function [ V ] = CalculACP( echantillon )
%CALCULACP Summary of this function goes here
%   Detailed explanation goes here
moy = mean(echantillon);
C = echantillon - repmat(moy,size(echantillon, 1), 1);

S = (size(C,1)-1) * cov(C);

[e lambda] = eigs(S)

[tri Itri] = sort(lambda)

vtri = e;
for i = 1:length(lambda)
vtri(:,i) = e(:,Itri(i));

V = vtri;
end

