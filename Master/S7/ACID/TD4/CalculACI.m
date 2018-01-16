function [ V ] = CalculACI( E1 , E2 )
%CALCULACI Summary of this function goes here
%   Detailed explanation goes here

Mu1  = mean(E1); 
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

invSwSB = Sw \ SB;

[e, lambda] = eigs(invSwSB);
diagonal = diag(lambda); 
[tri,Itri] = sort(diagonal,'descend'); 
vtri = e;
for i = 1:length(lambda)
vtri(:,i) = e(:,Itri(i)); 
end

V = vtri;

end

