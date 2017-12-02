function [ Wn ] = Perceptron( C1, C2, W )
%PERCEPTRON Summary of this function goes here
%   Detailed explanation goes here
% C1 sample from class 1
% C2 sample from class 2
% W the vectore 

colone1 = ones(length(C1),1)';
C1transfo = [colone1; C1]

colone1 = ones(length(C2),1)';
C2transfo = [colone1; C2];
C2transfo = C2transfo .* -1;
Y = [C1transfo C2transfo];
Ym = MalClasse(Y,W);
Wnext = W

mu = 0.2;


while ~isempty(Ym)
    Wprec = Wnext
    Ym = MalClasse(Y,Wnext)
    Wnext = Wprec - mu*sum(Ym,2)
end

Wn = Wnext

end

