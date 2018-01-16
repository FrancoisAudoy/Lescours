function [W] = moindresCarresSansOpt(C1, C2, B)
    C1y = [ ones(1,size(C1, 1)); transpose(C1)];
    C2y = [ -ones(1,size(C2, 1)); -transpose(C2)];
    Y = [ C1y C2y ];
    W = transpose(Y) \ B;
    
end
