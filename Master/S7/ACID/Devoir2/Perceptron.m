function [ Wn ] = Perceptron( Y, W )
%PERCEPTRON Summary of this function goes here
%   Detailed explanation goes here
% C1 sample from class 1
% C2 sample from class 2
% W the vectore 

Ym = MalClasse(Y,W);
mu = 0.1;

Wprec = W;
Wnext = Wprec + mu*sum(Ym,2);
i = 1;

while (~isempty(Ym) & (abs(Wnext - Wprec) > 0.001))
    Wprec = Wnext;
    Wnext = Wprec + (mu/i)*sum(Ym,2);
    Ym = MalClasse(Y,Wnext);
    i = i+1;
end

Wn = Wnext;

end

