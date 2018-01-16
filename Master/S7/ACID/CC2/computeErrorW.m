function [errorC2, errorC1] = computeErrorW(C2, C1, W)

  C1y = [ ones(1,size(C1, 1)); transpose(C1)];
  C2y = [ -ones(1,size(C2, 1)); -transpose(C2)];
  
  errorC1 = sum((transpose(W)*C1y) < 0)/size(C1,1);
  errorC2 = sum((transpose(W)*C2y) < 0)/size(C2,1);
end