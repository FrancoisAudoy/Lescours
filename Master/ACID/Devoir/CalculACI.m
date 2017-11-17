function [ V ] = CalculACI( E1 , E2 )
%CALCULACI Summary of this function goes here
%   Detailed explanation goes here

%s = length(X);

Mu1  = mean(E1); %ones(s,1);
Mu2 = mean(E2);
Mu = (Mu1 + Mu2) ./2;

S1 = cov(E1);
S2 = cov(E2);
Sw = S1 + S2;

N1 = size(E1,1);
N2 = size(E2,1);

SB1 = N1 .* (Mu1 - Mu)'*(Mu1 - Mu);
SB2 = N2 .* (Mu2 - Mu)'*(Mu2 - Mu);
SB = SB1 + SB2;

invSw = inv(Sw);
invSwSB = invSw * SB;

[V,lambda] = eig(invSwSB);
% [tri, itri] = sort(diag(lambda),'descend');
% 
% vtri = e;
% for i = 1:length(lambda)
% vtri(:,i) = e(:,itri(i)); % On tri les vecteurs propres en fonction des valeur propres 
% %grace à Itri qui contient les indices triés des valeurs propres triés
% end
% 
% e
% V = vtri


end

