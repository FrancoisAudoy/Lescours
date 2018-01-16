function [Y] = MatriceY (C1, C2)
  v1 = ones(1,size(C1, 1));
  v2 = ones(1,size(C2, 1));
  Y = [ [ v1; transpose(C1)] [ -v2; -transpose(C2)] ];
end