
% cr??ation des donn??es

m = 40;
sizeNoise = 10;
x = rand(m,1).*50 + 5;
noise = rand(m,1) * sizeNoise;
pente = 0.8;
b =  20;
y = b + pente*x + noise;

% r??gression matlab

X = [ones(length(x),1), x];
droiteMatlab = regress(y, X)


% syst??me lin??aire

droiteSL = inv(X'*X)*X'*y
droiteSLpierrick = X\y

% descente de gradient

theta = [10 1];
epsilon = 0.1;
nu = 0.0005;

[dtheta0,dtheta1] = gradientJ (theta, x, y);

dist = norm([dtheta0,dtheta1]); 
  
while(dist > epsilon)
   
    theta = theta - nu*[dtheta0 dtheta1];
    
    [dtheta0,dtheta1] = gradientJ (theta, x, y);
    
    dist = norm([dtheta0,dtheta1]);
end

theta


figure
hold on
plot(x, y, 'o')
xd = [0, 60];
%yd = [droiteMatlab(1), (60*droiteMatlab(2)+ droiteMatlab (1))];
%plot(xd , yd)
yd = [theta(1), (60*theta(2)+ theta(1))];
plot(xd , yd, 'r')
%yd = [droiteSL(1), (60*droiteSL(2)+ droiteSL(1))];
%plot(xd , yd, 'g')
