load ('donnees2.mat')

close all
figure('Name','Echantillons');
hold on

axis equal
scatter3(C3(:, 1), C3(:,2),C3(:, 3))
scatter3(C4(:, 1), C4(:,2),C4(:, 3), 'r')
legend('C3','C4');

mean(C3)
mean(C4)
hold off

mcost = [1 0; 0 1];

sizeC3 = length(C3);
sizeC4 = length(C4);

%% MAP

nbIter = 100;
%sizeTrain = 100;
nbC3Erreur = zeros(nbIter);
nbC4Erreur = zeros(nbIter);
erreurmoyenne = zeros(nbIter);
for i=1:nbIter
    sizeC1train = sizeC3 * 10 / 100;
    C3Indice = randperm(sizeC3, sizeC3);
    TrainC3Indice = C3Indice(1:sizeC1train);
    TrainC3 = C3(TrainC3Indice,:);
    muC3Train = mean(TrainC3);
    sigmaC3Train = cov(TrainC3);
    
    sizeC4train = sizeC4 * 10 / 100;
    C4Indice = randperm(sizeC4,sizeC4);
    TrainC4Indice = C4Indice(1:sizeC4train);
    TrainC4 = C4(TrainC4Indice,:);
    muC4Train = mean(TrainC4);
    sigmaC4Train = cov(TrainC4);
    
    TestC4Indice =  C4Indice(sizeC4train+1:sizeC4);
    TestC3Indice =  C3Indice(sizeC1train+1:sizeC3);
    
    TestC4 =  [C4(TestC4Indice,:); C4(TestC4Indice,:)];
    TestC3 = [C3(TestC3Indice,:); C3(TestC3Indice,:)];
    
    ResC4 = MyClassifBayesien(TestC4,muC4Train,sigmaC4Train,muC3Train,sigmaC3Train,mcost, sizeC4, sizeC3);
    ResC3 = MyClassifBayesien(TestC3,muC4Train,sigmaC4Train,muC3Train,sigmaC3Train,mcost, sizeC4, sizeC3);
    nbC3Erreur(i) = sum(ResC3) ./ (length(TestC4) + length(TestC3)) * 100;
    nbC4Erreur(i) = (size(ResC4,1)-sum(ResC4)) ./ (length(TestC4) + length(TestC3)) * 100;
    
    erreurmoyenne(i) = ((nbC3Erreur(i) * length(TestC3)) + (nbC4Erreur(i) * length(TestC4)))./ (length(TestC3) + length(TestC4));
end;

figure('Name','Erreur');
hold on
plot(1:nbIter,nbC3Erreur,'b')
plot(1:nbIter,nbC4Erreur, 'r')
plot(1:nbIter, erreurmoyenne,'g')
hold off

%% ACP
echantillons_total = [C3;C4];
figure('Name','Echantillons Total + Projection des classes');
scatter3(echantillons_total(:,1),echantillons_total(:,2),echantillons_total(:,3),'g');

[acp, C, moy] = CalculACP(echantillons_total);

W2 = transpose([acp(:,1),acp(:,2)]);
%figure('Name','Projection des Classes');
hold on
C3Proj = transpose(W2 * C3');
C4Proj = transpose(W2*C4');
scatter(C3Proj(:,1),C3Proj(:,2),'b')
scatter(C4Proj(:,1),C4Proj(:,2),'r')

sizeC1Proj = length(C3Proj);
sizeC2Proj = length(C4Proj);

nbIter = 100;
sizeTrain = 100;
nbC3Erreur = zeros(nbIter);
nbC4Erreur = zeros(nbIter);
erreurmoyenne = zeros(nbIter);
for i=1:nbIter
    sizeC1train = sizeC1Proj * 10 / 100;
    C3Indice = randperm(sizeC1Proj, sizeC1Proj);
    TrainCIndice = C3Indice(1:sizeC1train);
    TrainC3 = C3Proj(TrainCIndice,:);
    muC3Train = mean(TrainC3);
    sigmaC3Train = cov(TrainC3);
    
    sizeC4train = sizeC2Proj * 10 / 100;
    C4Indice = randperm(sizeC2Proj,sizeC2Proj);
    TrainC4Indice = C4Indice(1:sizeC4train);
    TrainC4 = C4Proj(TrainC4Indice,:);
    muC4Train = mean(TrainC4);
    sigmaC4Train = cov(TrainC4);
    
    TestC4Indice =  C4Indice(sizeC4train+1:sizeC2Proj);
    TestC3Indice =  C3Indice(sizeC1train+1:sizeC1Proj);
    
    TestC4 =  [C4Proj(TestC4Indice,:); C4Proj(TestC4Indice,:)];
    TestC3 = [C3Proj(TestC3Indice,:); C3Proj(TestC3Indice,:)];
    
    ResC4 = MyClassifBayesien(TestC4,muC4Train,sigmaC4Train,muC3Train,sigmaC3Train,mcost, sizeC2Proj, sizeC1Proj);
    ResC3 = MyClassifBayesien(TestC3,muC4Train,sigmaC4Train,muC3Train,sigmaC3Train,mcost, sizeC2Proj, sizeC1Proj);
    nbC3Erreur(i) = sum(ResC3) ./ (length(TestC4) + length(TestC3)) * 100;
    nbC4Erreur(i) = (size(ResC4,1)-sum(ResC4)) ./ (length(TestC4) + length(TestC3)) * 100;
    
    erreurmoyenne(i) = ((nbC3Erreur(i) * length(TestC3)) + (nbC4Erreur(i) * length(TestC4)))./ (length(TestC3) + length(TestC4));
end;
figure('Name','Erreur Apres ACP');
hold on
plot(1:nbIter,nbC3Erreur,'b')
plot(1:nbIter,nbC4Erreur, 'r')
plot(1:nbIter, erreurmoyenne,'g')
hold off