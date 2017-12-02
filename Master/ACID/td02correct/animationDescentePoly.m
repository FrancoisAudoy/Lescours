close all

x = 0:0.1:6;
nu = 0.01;
epsilon = 0.01; 
coefpoly = [30 -61 41 -11 1] % exemple poly
% coef dans l'ordre croissant des puissances.


y = valeurPolynome(x, coefpoly);
derive = derivPoly(coefpoly);

figure;
hold on;

plot(x,y);

x0 = 5;
xprec = x0;
xcurrent = xprec - nu*valeurPolynome(xprec, derive)

plot(x0,valeurPolynome(xprec,coefpoly),'ok','MarkerSize',20);

while(abs(xprec - xcurrent) > epsilon)
  plot(xcurrent, valeurPolynome(xcurrent, coefpoly),'ob');
  xprec  = xcurrent;
  xcurrent = xprec - nu*valeurPolynome(xprec, derive);
  pause(1);
end

plot(xcurrent,valeurPolynome(xcurrent, coefpoly),'xr', 'MarkerSize',20);

