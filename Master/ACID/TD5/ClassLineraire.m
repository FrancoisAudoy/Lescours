%% load('donnees.mat');
close all;

C1 = [2 1; 3 2; 4 2]';
C2 = [1 2; 1 3; 2 3; 5 3]';

figure('Name','Data');
hold on
axis([0 5 0 4]);
scatter(C1(1,:),C1(2,:), 'b');
scatter(C2(1,:),C2(2,:), 'r');
hold off

%% Approche Linéaire 

colone1 = ones(length(C1),1)';
C1transfo = [colone1; C1];

colone2 = ones(length(C2),1)';
C2transfo = [colone2; C2];
C2transfo = C2transfo .* -1;

Y = [C1transfo C2transfo];

W = [1; -3];
W0 =  Resoud(W,[0;2])
Ym = MalClasse(Y, [W0; W])

hold on
VDir = [-W(2,1) W(1,1)]
plot(0:6, droite2DVd(0:6,VDir,[0 2]));
hold off

%% Perceptron

Wn = Perceptron(C1,C2,[W0 ;W])
bestW0 = Wn(1,1)
W  = [Wn(2,1)   Wn(3,1)]
VDir = [-W(1,2) W(1,1)]
figure('Name','Perceptron');
hold on
axis equal
scatter(C1(1,:),C1(2,:));
scatter(C2(1,:),C2(2,:));
plot(0:6, droite2DVd(0:6,VDir,[0 1.4]));
hold off
