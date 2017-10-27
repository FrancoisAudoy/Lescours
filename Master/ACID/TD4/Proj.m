function [ yproj ] = Proj( W, echantillon )
%PROJ Summary of this function goes here
%   Detailed explanation goes here

yproj = transpose(W*echantillon');

end

