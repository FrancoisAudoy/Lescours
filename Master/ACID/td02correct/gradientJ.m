
% J est l'erreur quadratique moyenne (distance verticale)

function [dtheta0 dtheta1] = gradientJ (theta, x, y)

theta0 = theta(1)
theta1 = theta(2)
dtheta0 = sum(theta0 + theta1 * x - y);
dtheta1 = sum(x .* (theta0 + theta1* x - y));

m = length (x);
dtheta0 = 2*dtheta0 / m;
dtheta1 = 2*dtheta1 / m;
