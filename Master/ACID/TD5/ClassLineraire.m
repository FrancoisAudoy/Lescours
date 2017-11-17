load('donnees.mat');

figure('Name','Data');
scatter(C1(:,1),C1(:,2), '.b');
hold on
scatter(C2(:,1),C2(:,2), '.r');
hold off

mcost = [1 0; 0 1];

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
    
    TestC2Indice =  C2Indice(sizeC2train+1:sizeC2);
    TestC1Indice =  C1Indice(sizeC1train+1:sizeC1);
    
    TestC2 =  [C2(TestC2Indice,:); C2(TestC2Indice,:)];
    TestC1 = [C1(TestC1Indice,:); C1(TestC1Indice,:)];
    
    ResC2 = MyClassifBayesien(TestC2,muC2Train,sigmaC2Train,muC1Train,sigmaC1Train,mcost, sizeC2, sizeC1);
    ResC1 = MyClassifBayesien(TestC1,muC2Train,sigmaC2Train,muC1Train,sigmaC1Train,mcost, sizeC2, sizeC1);
    nbC1Erreur(i) = sum(ResC1) ./ (length(TestC2) + length(TestC1)) * 100;
    nbC2Erreur(i) = (size(ResC2,1)-sum(ResC2)) ./ (length(TestC2) + length(TestC1)) * 100;
    
    erreurmoyenne(i) = ((nbC1Erreur(i) * length(TestC1)) + (nbC2Erreur(i) * length(TestC2)))./ (length(TestC1) + length(TestC2));
end;

figure('Name','Erreur');
hold on
plot(1:nbIter,nbC1Erreur,'b')
plot(1:nbIter,nbC2Erreur, 'r')
plot(1:nbIter, erreurmoyenne,'g')
hold off