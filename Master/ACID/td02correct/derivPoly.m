function [ derive ] = derivPoly(poly)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

l = length(poly);
puissance = [0:l-1];

derive = poly.*puissance;

derive(1) = [];


end

