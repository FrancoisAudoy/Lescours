load ('donnees1.mat')
load('donnees2.mat')

close all
figure('name', 'C1 et C2');
hold on
axis equal
scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')
legend('C1','C2');
hold off


mean(C1)
mean(C2)
% MAP
sizeC1 = length(C1);
sizeC2 = length(C2);

nbIter = 100;
sizeTrain = 100;
nbC1Erreur = zeros(nbIter);
nbC2Erreur = zeros(nbIter);
erreurmoyenne = zeros(nbIter);
for i=1:nbIter
    sizeC1train = length(C1) * 10 / 100;
    C1Indice = randperm(sizeC1, sizeC1);
    TrainC1Indice = C1Indice(1:sizeC1train);
    TrainC1 = C1(TrainC1Indice,:);
    muC1Train = mean(TrainC1);
    sigmaC1Train = cov(TrainC1);
    
    sizeC2train = length(C2) * 10 / 100;
    C2Indice = randperm(sizeC2,sizeC2);
    TrainC2Indice = C2Indice(1:sizeC2train);
    TrainC2 = C2(TrainC2Indice,:);
    muC2Train = mean(TrainC2);
    sigmaC2Train = cov(TrainC2);
    
    TestC2Indice =  C2Indice(sizeTrain+1:sizeC2);
    TestC1Indice =  C1Indice(sizeTrain+1:sizeC1);
    
    TestC2 =  [C2(TestC2Indice,:); C2(TestC2Indice,:)];
    TestC1 = [C1(TestC1Indice,:); C1(TestC1Indice,:)];
    
    ResC2 = MyClassify(TestC2,muC2Train,sigmaC2Train,muC1Train,sigmaC1Train, sizeC2, sizeC1);
    ResC1 = MyClassify(TestC1,muC2Train,sigmaC2Train,muC1Train,sigmaC1Train,sizeC2, sizeC1);
    nbC1Erreur(i) = (size(ResC2,1)-sum(ResC2)) ./ (length(TestC2) + length(TestC1));
    nbC2Erreur(i) = sum(ResC1) ./ (length(TestC2) + length(TestC1));
    
    erreurmoyenne(i) = ((nbC1Erreur(i) * length(TestC2)) + (nbC2Erreur(i) * length(TestC1)))./ (length(TestC1) + length(TestC2));
end;

figure('Name','Erreur');
hold on
plot(1:nbIter,nbC1Erreur,'b')
plot(1:nbIter,nbC2Erreur, 'r')
plot(1:nbIter, erreurmoyenne,'g')
legend('C1','C2','Erreur')
hold off

%ACP
ech = [C1;C2];
[acp, C, moy] = CalculACP(ech);
figure('Name','ACP');
scatter3(ech(:,1),ech(:,2),ech(:,3));
hold on
W = transpose([acp(:,1),acp(:,2)]);
Cproj = transpose(W * C');
plot(acp(:,1),acp(:,2),'r');
scatter(Cproj(:,1),Cproj(:,2));
hold off
