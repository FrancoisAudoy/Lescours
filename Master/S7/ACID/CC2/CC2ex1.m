load ('donnees1.mat')
close all
clc;

figure('name','Visualisation des Données')
hold on
axis equal
scatter3(C1(:, 1), C1(:,2),C1(:, 3));
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r');
hold off


nbIter = 100;
sizeC1 = size(C1, 1);
sizeC2 = size(C2, 1);

sizeTrainC1 = sizeC1/10;
sizeTrainC2 = sizeC2/10;

pC1 = sizeC1/(sizeC1+sizeC2);
pC2 = sizeC2/(sizeC1+sizeC2);

% Exercice 1.1 : Erreur MAP
errorC1MAP = zeros(nbIter, 1);
errorC2MAP = zeros(nbIter, 1);
errorMAP   = zeros(nbIter, 1);

% Exercice 1.2 : Erreur Perceptron
errorC1Perceptron = zeros(nbIter, 1);
errorC2Perceptron = zeros(nbIter, 1);
errorPerceptron   = zeros(nbIter, 1);
BestWp = [ 1; 1; 1; 1];
minErrorPerceptron = sizeC1+sizeC2;

% Exercice 1.3 : Erreur Moindre Carrée Sans Optimisation
errorC1MCS = zeros(nbIter, 1);
errorC2MCS = zeros(nbIter, 1);
errorMCS   = zeros(nbIter, 1);
BestWmcs = [ 1; 1; 1; 1];
minErrorMCS = sizeC1+sizeC2;

% Exercice 1.3 : Erreur Moindre Carrée Avec Optimisation
errorC1MCA = zeros(nbIter, 1);
errorC2MCA = zeros(nbIter, 1);
errorMCA   = zeros(nbIter, 1);
BestWmca = [ 1; 1; 1; 1];
minErrorMCA = sizeC1+sizeC2;

for i=1:nbIter
    
  [TrainC2,TestC2,TrainC1, TestC1] = extractTestAndTrainN(C2, C1, sizeTrainC2, sizeTrainC1);
  [modelC2] = TrainModel(TrainC2);
  [modelC1] = TrainModel(TrainC1);
  
  % Exercice 1.1 : MAP
  ResC1  =   MyclassifyN(TestC1,modelC1, modelC2, pC1, pC2);
  ResC2  =   MyclassifyN(TestC2,modelC1, modelC2, pC1, pC2);
  [C2Error, C1Error] = computeErrorMAP(ResC2, ResC1);
  errorC2MAP(i) = C2Error*100;
  errorC1MAP(i) = C1Error*100;
  errorMAP(i)   = (length(TestC2) * errorC2MAP(i) + length(TestC1) *  errorC1MAP(i) )/ (length(TestC2) + length(TestC1));
  
  % Exercice 1.2 : Perceptron
  Wp = [ 1; 1; 1; 1];
  Wp = Perceptron (TrainC1, TrainC2, Wp);
  [C2Error, C1Error] = computeErrorW(TestC2, TestC1, Wp);
  errorC2Perceptron(i) = C2Error*100;
  errorC1Perceptron(i) = C1Error*100;
  errorPerceptron(i)   = (length(TestC2) * errorC2Perceptron(i) + length(TestC1) *  errorC1Perceptron(i) )/ (length(TestC2) + length(TestC1));
  if errorPerceptron(i)< minErrorPerceptron
      BestWp = Wp;
      minErrorPerceptron = errorPerceptron(i);
  end
  
  % Exercice 1.3 : Moindre Carrée Sans Optimisation
  B = ones(sizeTrainC1+sizeTrainC2, 1);
  Wmcs = moindresCarresSansOpt(TrainC1, TrainC2, B);
  [C2Error, C1Error] = computeErrorW(TestC2, TestC1, Wmcs);
  errorC2MCS(i) = C2Error*100;
  errorC1MCS(i) = C1Error*100;
  errorMCS(i)   = (length(TestC2) * errorC2MCS(i) + length(TestC1) *  errorC1MCS(i) )/ (length(TestC2) + length(TestC1));
  if errorMCS(i)< minErrorMCS
      BestWmcs = Wmcs;
      minErrorMCS = errorMCS(i);
  end
  
  % Exercice 1.4 : Moindre Carrée Avec Optimisation
  B = ones(sizeTrainC1+sizeTrainC2, 1);
  Wmca = moindresCarresAvecOpt(TrainC1, TrainC2, B);
  [C2Error, C1Error] = computeErrorW(TestC2, TestC1, Wmca);
  errorC2MCA(i) = C2Error*100;
  errorC1MCA(i) = C1Error*100;
  errorMCA(i)   = (length(TestC2) * errorC2MCA(i) + length(TestC1) *  errorC1MCA(i) )/ (length(TestC2) + length(TestC1));
  if errorMCA(i)< minErrorMCA
      BestWmca = Wmca;
      minErrorMCA = errorMCA(i);
  end
  
end

% Exercice 1.1 : Mean Erreur MAP
MeanErrorC1MAP  = mean(errorC1MAP);
MeanErrorC2MAP  = mean(errorC2MAP);
MeanErrorMAP    = mean(errorMAP);

% Exercice 1.2 : Mean Erreur Perceptron
MeanErrorC1Perceptron  = mean(errorC1Perceptron);
MeanErrorC2Perceptron  = mean(errorC2Perceptron);
MeanErrorPerceptron    = mean(errorPerceptron);

% Exercice 1.3 : Mean Erreur Moindre Carrée Sans Optimisation
MeanErrorC1MCS  = mean(errorC1MCS);
MeanErrorC2MCS  = mean(errorC2MCS);
MeanErrorMCS    = mean(errorMCS);

% Exercice 1.3 : Mean Erreur Moindre Carrée Avec Optimisation
MeanErrorC1MCA  = mean(errorC1MCA);
MeanErrorC2MCA  = mean(errorC2MCA);
MeanErrorMCA    = mean(errorMCA);



figure('Name', 'errorMAP');
plot(1:nbIter, errorC1MAP, 'g')
hold on
plot(1:nbIter, errorC2MAP)
plot(1:nbIter, errorMAP, 'k')
xlabel(['MeanErrorC1MAP: ', num2str(MeanErrorC1MAP), '%; MeanErrorC2MAP: ', num2str(MeanErrorC2MAP), '%; MeanErrorMAP: ', num2str(MeanErrorMAP), '%']);
legend('errorC1MAP(%)','errorC2MAP(%)','errorMAP(%)');
hold off
%ylim([0 100])



figure('name','Visualisation de Perceptron')
hold on
axis equal
scatter3(C1(:, 1), C1(:,2),C1(:, 3));
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r');
[x y] = meshgrid(-5:0.1:20);
h = -1/BestWp(4,:)*(BestWp(1,:) + BestWp(2,:)*x + BestWp(3,:)*y);
surf(x,y,h)
hold off

figure('Name', 'errorPerceptron');
plot(1:nbIter, errorC1Perceptron, 'g')
hold on
plot(1:nbIter, errorC2Perceptron)
plot(1:nbIter, errorPerceptron, 'k')
xlabel(['MeanErrorC1Perceptron: ', num2str(MeanErrorC1Perceptron), '%; MeanErrorC2Perceptron: ', num2str(MeanErrorC2Perceptron), '%; MeanErrorPerceptron: ', num2str(MeanErrorPerceptron), '%']);
legend('errorC1Perceptron(%)','errorC2Perceptron(%)','errorPerceptron(%)');
hold off
%ylim([0 100])



figure('name','Visualisation de W MCS')
hold on
axis equal
scatter3(C1(:, 1), C1(:,2),C1(:, 3));
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r');
[x y] = meshgrid(-5:0.1:20);
h = -1/BestWmcs(4,:)*(BestWmcs(1,:) + BestWmcs(2,:)*x + BestWmcs(3,:)*y);
surf(x,y,h)
hold off

figure('Name', 'errorMCS');
plot(1:nbIter, errorC1MCS, 'g')
hold on
plot(1:nbIter, errorC2MCS)
plot(1:nbIter, errorMCS, 'k')
xlabel(['MeanErrorC1MCS: ', num2str(MeanErrorC1MCS), '%; MeanErrorC2MCS: ', num2str(MeanErrorC2MCS), '%; MeanErrorMCS: ', num2str(MeanErrorMCS), '%']);
legend('errorC1MCS(%)','errorC2MCS(%)','errorMCS(%)');
hold off
%ylim([0 100])



figure('name','Visualisation de W MCA')
hold on
axis equal
scatter3(C1(:, 1), C1(:,2),C1(:, 3));
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r');
[x y] = meshgrid(-5:0.1:20);
h = -1/BestWmca(4,:)*(BestWmca(1,:) + BestWmca(2,:)*x + BestWmca(3,:)*y);
surf(x,y,h)
hold off

figure('Name', 'errorMCA');
plot(1:nbIter, errorC1MCA, 'g')
hold on
plot(1:nbIter, errorC2MCA)
plot(1:nbIter, errorMCA, 'k')
xlabel(['MeanErrorC1MCA: ', num2str(MeanErrorC1MCA), '%; MeanErrorC2MCA: ', num2str(MeanErrorC2MCA), '%; MeanErrorMCA: ', num2str(MeanErrorMCA), '%']);
legend('errorC1MCA(%)','errorC2MCA(%)','errorMCA(%)');
hold off
%ylim([0 100])