function [ Ym ] = MalClasse( Y, W )
%MALCLASSE Summary of this function goes here
%   Detailed explanation goes here
% Y must be a colone vector
indErr = W'*Y < 0 ;
Ym = Y(:,indErr);
% Ym = [];
% for i = 1:length(Y)
%     if( )
%         Ym =  repmat([Ym Y(:,i)],1);
%     end
% end

end

