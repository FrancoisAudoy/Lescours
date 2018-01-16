function [W] = moindresCarresAvecOpt(C1, C2, B)
  
  C1y = [ ones(1,size(C1, 1)); transpose(C1)];
  C2y = [ -ones(1,size(C2, 1)); -transpose(C2)];
  Y = [ C1y C2y ];
  Z = transpose(Y);
  W = Z \ B;
  
  nu  = 0.5;
  epsilon = 0.001;
  
  Bc = B - (-2*((Z*W) - B));
  Bc = Bc.*(Bc>0);
  Bp = B;
  
  W = Z \Bc;
  
  k=1;
  while(norm(Bp - Bc) > epsilon)
  
    Bp  = Bc;
    W  = Z \Bc;
    k=k+1;
    Bc = Bc - (nu/k)* (-2*((Z*W) - Bc));
    Bc = Bc.*(Bc>0);
    
  end
  
  v = Z \Bc;
  
end