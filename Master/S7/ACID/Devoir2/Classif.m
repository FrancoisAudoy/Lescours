function [ res ] = Classif( X, a, W0 )
%CLASSIFPERCEPTRON Summary of this function goes here
%   Detailed explanation goes here
res = ((X * a) + W0) >= 0;
end

