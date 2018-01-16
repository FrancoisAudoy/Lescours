load ('donnees2.mat')
close all
clc;

figure('name','Visualisation des Données')
hold on
axis equal
scatter3(C3(:, 1), C3(:,2),C3(:, 3));
scatter3(C4(:, 1), C4(:,2),C4(:, 3), 'r');
hold off


nbIter = 100;
sizeC3 = size(C3, 1);
sizeC4 = size(C4, 1);

sizeTrainC3 = sizeC3/10;
sizeTrainC4 = sizeC4/10;

pC3 = sizeC3/(sizeC3+sizeC4);
pC4 = sizeC4/(sizeC3+sizeC4);

% Exercice 1.1 : Erreur MAP
errorC3MAP = zeros(nbIter, 1);
errorC4MAP = zeros(nbIter, 1);
errorMAP   = zeros(nbIter, 1);

% Exercice 1.2 : Erreur Perceptron
errorC3Perceptron = zeros(nbIter, 1);
errorC4Perceptron = zeros(nbIter, 1);
errorPerceptron   = zeros(nbIter, 1);
BestWp = [ 1; 1; 1; 1];
minErrorPerceptron = sizeC3+sizeC4;

% Exercice 1.3 : Erreur Moindre Carrée Sans Optimisation
errorC3MCS = zeros(nbIter, 1);
errorC4MCS = zeros(nbIter, 1);
errorMCS   = zeros(nbIter, 1);
BestWmcs = [ 1; 1; 1; 1];
minErrorMCS = sizeC3+sizeC4;

% Exercice 1.3 : Erreur Moindre Carrée Avec Optimisation
errorC3MCA = zeros(nbIter, 1);
errorC4MCA = zeros(nbIter, 1);
errorMCA   = zeros(nbIter, 1);
BestWmca = [ 1; 1; 1; 1];
minErrorMCA = sizeC3+sizeC4;

for i=1:nbIter

  [TrainC4,TestC4,TrainC3, TestC3] = extractTestAndTrainN(C4, C3, sizeTrainC4, sizeTrainC3);
  [modelC4] = TrainModel(TrainC4);
  [modelC3] = TrainModel(TrainC3);

  % Exercice 1.1 : MAP
  ResC3  =   MyclassifyN(TestC3,modelC3, modelC4, pC3, pC4);
  ResC4  =   MyclassifyN(TestC4,modelC3, modelC4, pC3, pC4);
  [C4Error, C3Error] = computeErrorMAP(ResC4, ResC3);
  errorC4MAP(i) = C4Error*100;
  errorC3MAP(i) = C3Error*100;
  errorMAP(i)   = (length(TestC4) * errorC4MAP(i) + length(TestC3) *  errorC3MAP(i) )/ (length(TestC4) + length(TestC3));

  % Exercice 1.2 : Perceptron
  Wp = [ 1; 1; 1; 1];
  Wp = Perceptron (TrainC3, TrainC4, Wp);
  [C4Error, C3Error] = computeErrorW(TestC4, TestC3, Wp);
  errorC4Perceptron(i) = C4Error*100;
  errorC3Perceptron(i) = C3Error*100;
  errorPerceptron(i)   = (length(TestC4) * errorC4Perceptron(i) + length(TestC3) *  errorC3Perceptron(i) )/ (length(TestC4) + length(TestC3));
  if errorPerceptron(i)< minErrorPerceptron
      BestWp = Wp;
      minErrorPerceptron = errorPerceptron(i);
  end

  % Exercice 1.3 : Moindre Carrée Sans Optimisation
  B = ones(sizeTrainC3+sizeTrainC4, 1);
  Wmcs = moindresCarresSansOpt(TrainC3, TrainC4, B);
  [C4Error, C3Error] = computeErrorW(TestC4, TestC3, Wmcs);
  errorC4MCS(i) = C4Error*100;
  errorC3MCS(i) = C3Error*100;
  errorMCS(i)   = (length(TestC4) * errorC4MCS(i) + length(TestC3) *  errorC3MCS(i) )/ (length(TestC4) + length(TestC3));
  if errorMCS(i)< minErrorMCS
      BestWmcs = Wmcs;
      minErrorMCS = errorMCS(i);
  end

  % Exercice 1.4 : Moindre Carrée Avec Optimisation
  B = ones(sizeTrainC3+sizeTrainC4, 1);
  Wmca = moindresCarresAvecOpt(TrainC3, TrainC4, B);
  [C4Error, C3Error] = computeErrorW(TestC4, TestC3, Wmca);
  errorC4MCA(i) = C4Error*100;
  errorC3MCA(i) = C3Error*100;
  errorMCA(i)   = (length(TestC4) * errorC4MCA(i) + length(TestC3) *  errorC3MCA(i) )/ (length(TestC4) + length(TestC3));
  if errorMCA(i)< minErrorMCA
      BestWmca = Wmca;
      minErrorMCA = errorMCA(i);
  end

end

% Exercice 1.1 : Mean Erreur MAP
MeanErrorC3MAP  = mean(errorC3MAP);
MeanErrorC4MAP  = mean(errorC4MAP);
MeanErrorMAP    = mean(errorMAP);

% Exercice 1.2 : Mean Erreur Perceptron
MeanErrorC3Perceptron  = mean(errorC3Perceptron);
MeanErrorC4Perceptron  = mean(errorC4Perceptron);
MeanErrorPerceptron    = mean(errorPerceptron);

% Exercice 1.3 : Mean Erreur Moindre Carrée Sans Optimisation
MeanErrorC3MCS  = mean(errorC3MCS);
MeanErrorC4MCS  = mean(errorC4MCS);
MeanErrorMCS    = mean(errorMCS);

% Exercice 1.3 : Mean Erreur Moindre Carrée Avec Optimisation
MeanErrorC3MCA  = mean(errorC3MCA);
MeanErrorC4MCA  = mean(errorC4MCA);
MeanErrorMCA    = mean(errorMCA);



figure('Name', 'errorMAP');
plot(1:nbIter, errorC3MAP, 'g')
hold on
plot(1:nbIter, errorC4MAP)
plot(1:nbIter, errorMAP, 'k')
xlabel(['MeanErrorC3MAP: ', num2str(MeanErrorC3MAP), '%; MeanErrorC4MAP: ', num2str(MeanErrorC4MAP), '%; MeanErrorMAP: ', num2str(MeanErrorMAP), '%']);
legend('errorC3MAP(%)','errorC4MAP(%)','errorMAP(%)');
hold off
%ylim([0 100])



figure('name','Visualisation de Perceptron')
hold on
axis equal
scatter3(C3(:, 1), C3(:,2),C3(:, 3));
scatter3(C4(:, 1), C4(:,2),C4(:, 3), 'r');
[x y] = meshgrid(-5:0.1:20);
h = -1/BestWp(4,:)*(BestWp(1,:) + BestWp(2,:)*x + BestWp(3,:)*y);
surf(x,y,h)
hold off

figure('Name', 'errorPerceptron');
plot(1:nbIter, errorC3Perceptron, 'g')
hold on
plot(1:nbIter, errorC4Perceptron)
plot(1:nbIter, errorPerceptron, 'k')
xlabel(['MeanErrorC3Perceptron: ', num2str(MeanErrorC3Perceptron), '%; MeanErrorC4Perceptron: ', num2str(MeanErrorC4Perceptron), '%; MeanErrorPerceptron: ', num2str(MeanErrorPerceptron), '%']);
legend('errorC3Perceptron(%)','errorC4Perceptron(%)','errorPerceptron(%)');
hold off
%ylim([0 100])



figure('name','Visualisation de W MCS')
hold on
axis equal
scatter3(C3(:, 1), C3(:,2),C3(:, 3));
scatter3(C4(:, 1), C4(:,2),C4(:, 3), 'r');
[x y] = meshgrid(-5:0.1:20);
h = -1/BestWmcs(4,:)*(BestWmcs(1,:) + BestWmcs(2,:)*x + BestWmcs(3,:)*y);
surf(x,y,h)
hold off

figure('Name', 'errorMCS');
plot(1:nbIter, errorC3MCS, 'g')
hold on
plot(1:nbIter, errorC4MCS)
plot(1:nbIter, errorMCS, 'k')
xlabel(['MeanErrorC3MCS: ', num2str(MeanErrorC3MCS), '%; MeanErrorC4MCS: ', num2str(MeanErrorC4MCS), '%; MeanErrorMCS: ', num2str(MeanErrorMCS), '%']);
legend('errorC3MCS(%)','errorC4MCS(%)','errorMCS(%)');
hold off
%ylim([0 100])



figure('name','Visualisation de W MCA')
hold on
axis equal
scatter3(C3(:, 1), C3(:,2),C3(:, 3));
scatter3(C4(:, 1), C4(:,2),C4(:, 3), 'r');
[x y] = meshgrid(-5:0.1:20);
h = -1/BestWmca(4,:)*(BestWmca(1,:) + BestWmca(2,:)*x + BestWmca(3,:)*y);
surf(x,y,h)
hold off

figure('Name', 'errorMCA');
plot(1:nbIter, errorC3MCA, 'g')
hold on
plot(1:nbIter, errorC4MCA)
plot(1:nbIter, errorMCA, 'k')
xlabel(['MeanErrorC3MCA: ', num2str(MeanErrorC3MCA), '%; MeanErrorC4MCA: ', num2str(MeanErrorC4MCA), '%; MeanErrorMCA: ', num2str(MeanErrorMCA), '%']);
legend('errorC3MCA(%)','errorC4MCA(%)','errorMCA(%)');
hold off
%ylim([0 100])
