function [W] = Perceptron (C1, C2, W);
  
  C1y = [ ones(1,size(C1, 1)); transpose(C1)];
  C2y = [ -ones(1,size(C2, 1)); -transpose(C2)];
  Y = [ C1y C2y ];
  Ym = calculer_mal_classes(Y, W);
  
  k=1;
  nu = 0.5;
  epsilon = 0.001;
  Wc = W + nu * sum(Ym,2);
  Wp = W;
  
  while(abs(Wp - Wc) > epsilon)
    k = k+1;
    Wp = Wc;
    Ym = calculer_mal_classes(Y, Wc);
    Wc = Wc + (nu/k) * sum(Ym , 2);
  end
  
  W = Wc;
  
end