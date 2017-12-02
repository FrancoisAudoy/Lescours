function [ Ym ] = MalClasse( Y, W )
%MALCLASSE Summary of this function goes here
%   Detailed explanation goes here
% Y must be a linear vector
Ym = [];
for i = 1:length(Y)
    if( W'*Y(:,i) < 0)
        Ym =  repmat([Ym Y(:,i)],1);
    end
end

end

