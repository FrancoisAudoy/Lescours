function [Ym] = calculer_mal_classes(Y, W)
  Error = (transpose(W)*Y) < 0;
  Ym = Y(:,Error);
end