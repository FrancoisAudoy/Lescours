load('donnees.mat');
close all;

%C1 = [2 1; 3 2; 4 2];
%C2 = [1 2; 1 3; 2 3; 5 3];

figure('Name','Data');
hold on
axis equal
scatter(C1(:,1),C1(:,2), 'b');
scatter(C2(:,1),C2(:,2), 'r');
legend('C1','C2');
hold off

%% Approche Linéaire 

colone1 = ones(length(C1),1);
C1transfo = [colone1 C1];

colone2 = ones(length(C2),1);
C2transfo = [colone2 C2];
C2transfo = C2transfo .* -1;

Y = [C1transfo; C2transfo]';

W = [1; -3];
W0 =  Resoud(W,[1; 1])
Ym = MalClasse(Y, [W0; W])

hold on
VDir = [-W(2,1) W(1,1)]
plot(-3:14, droite2DVd(-3:14,VDir,[0; W0]));
hold off

%% Perceptron

Wn = Perceptron(C1,C2,[W0 ;W])
bestW0 = Wn(1,1)
W  = [Wn(2,1); Wn(3,1)]
VDir = [-W(2,1) W(1,1)]
figure('Name','Perceptron');
hold on
axis equal
scatter(C1(:,1),C1(:,2));
scatter(C2(:,1),C2(:,2));
plot(-3:14, droite2DVd(-3:14,VDir,[0  bestW0]));
hold off

res = zeros(length(C2),1);
for i = 1:length(C2)
   res(i) =  Classif(C2(i,:), W, bestW0);
end
res

%% Moindre carré

b = ones(length(C1) + length(C2), 1);
Z = Y';
Wn = Z\b
W0 = Wn(1,1)
W = [Wn(2,1) ; Wn(3,1)];
figure('Name','Moindre carré');
hold on
axis equal
scatter(C1(:,1),C1(:,2));
scatter(C2(:,1),C2(:,2));
plot(-3:14, droite2DVd(-3:14,[-W(2,1); W(1,1)],[0 W0]));
hold off
resmc = zeros(length(C1),1);
for i = 1:length(C1)
   resmc(i) =  Classif(C1(i,:), W, W0);
end
resmc

%% moindre carré opti sur b