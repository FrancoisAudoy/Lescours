%
% % Calcul des valeurs propres / vecteurs propre d'une matrice (eig)
% % Visualisation des vecteurs propres de la matrice de covariance
% % d'un nuage de points
%
close all
clc
mu = [0 0]
sigma = [1 0 ; 0 1]
X = mvnrnd(mu,sigma,200); 


figure ('Name', 'Vecteurs propres');
axis equal
hold on
scatter(X(:,1), X(:,2));

A= cov(X);

[V D] = eig(A);
Vdir1 = V(:,1);
Vdir2 = V(:,2);
x=-2:2;

y1 = droite2DVd(x,Vdir1,mu);

plot(x,y1,'r')

y2 = droite2DVd(x,Vdir2,mu);

plot(x,y2,'g')
hold off 

moy = mean(X);
% C = X - repmat(moy,size(X, 1), 1)
[myacp, C] = CalculACP(X);
W1 = transpose((myacp(:,1)));
W2 = transpose([myacp(:,1),myacp(:,2)]);
CProj1 = Proj(W1,C);
CProj2 = Proj(W2,C);

ymyacp = droite2DVd(C,W1,moy);
yproj = droite2DVd(CProj1,W1,moy);
%figure('Name','ACP 1D');
hold on
scatter(CProj1, yproj,'g');

plot(C,ymyacp,'b');
hold off

% y2dacp = droite2DVd(C,W2,moy);
% figure('Name','ACP 2D');
% plot(C,y2dacp);