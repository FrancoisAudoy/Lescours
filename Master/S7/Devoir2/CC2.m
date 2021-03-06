load ('donnees1.mat')

close all
figure(1)
hold on

axis equal

scatter3(C1(:, 1), C1(:,2),C1(:, 3))
scatter3(C2(:, 1), C2(:,2),C2(:, 3), 'r')
hold off


mean(C1);
mean(C2);
hold off

mcost = [1 0; 0 1];

sizeC1 = length(C1);
sizeC2 = length(C2);

% W pour le Perceptron
Wp = [4; 2; -1]; % Init W: vecteur normal à la droite ;
W0p = 6;
%% Boucle de traitement

nbIter = 100;
nbC1Erreur = zeros(nbIter,1);
nbC2Erreur = zeros(nbIter,1);
erreurmoyenne = zeros(nbIter);

C1ErreurPerc = zeros(nbIter,1);
C2ErreurPerc = zeros(nbIter,1);
MoyErrPerc = zeros(nbIter,1);

C1ErreurMC = zeros(nbIter,1);
C2ErreurMC = zeros(nbIter,1);
MoyErrMC = zeros(nbIter,1);

C1ErreurMCO = zeros(nbIter,1);
C2ErreurMCO = zeros(nbIter,1);
MoyErrMCO = zeros(nbIter,1);

for i=1:nbIter
    %% extraction de l'ensemble TRAIN
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
    
    %% Extraction de l'ensemble de Test
    TestC2Indice =  C2Indice(sizeC2train+1:sizeC2);
    TestC1Indice =  C1Indice(sizeC1train+1:sizeC1);
    
    TestC2 =  C2(TestC2Indice,:);
    TestC1 = C1(TestC1Indice,:);
    
    %% MAP + Calcul d'erreur de MAP
    ResC2 = MyClassifBayesien(TestC2,muC2Train,sigmaC2Train,muC1Train,sigmaC1Train,mcost, sizeC2, sizeC1);
    ResC1 = MyClassifBayesien(TestC1,muC2Train,sigmaC2Train,muC1Train,sigmaC1Train,mcost, sizeC2, sizeC1);
    nbC1Erreur(i) = sum(ResC1) ./ (length(TestC2) + length(TestC1)) * 100;
    nbC2Erreur(i) = (length(ResC2) - sum(ResC2)) ./ (length(TestC2) + length(TestC1)) * 100;
    
    erreurmoyenne(i) = ((nbC1Erreur(i) * length(TestC1)) + (nbC2Erreur(i) * length(TestC2)))./ (length(TestC1) + length(TestC2));
    
    %% Approche Linéaire
    % Préparation + Entrainement du perceptron avec l'ensemble TRAIN
    
    Colone1 = ones(length(TrainC1),1);
    TrainC1Transfo = [Colone1 TrainC1];
    
    Colone1 = ones(length(TrainC2),1);
    TrainC2Transfo = [Colone1 TrainC2];
    TrainC2Transfo = TrainC2Transfo .* -1;
    
    Y = [TrainC1Transfo; TrainC2Transfo]';
    
    Ym = MalClasse(Y, [W0p; Wp]);
    
    Wn = Perceptron(Y, [W0p;Wp]);
    W0p = Wn(1,1);
    Wp = Wn(2:length(Wn),:);
    
    Colonne1 = ones(length(TestC1),1);
    YC1 = [Colonne1  TestC1]';
    Colonne1 = ones(length(TestC2),1);
    YC2 = -1 * [Colonne1 TestC2]';
    ResPercC1 = MalClasse(YC1 , [W0p;Wp]);
    ResPercC2 = MalClasse(YC2, [W0p; Wp]);
    
    C1ErreurPerc(i) = length(ResPercC1) ./ (length(TestC1) + length(TestC2));
    C2ErreurPerc(i) = length(ResPercC2) ./ (length(TestC1) + length(TestC2));
    
    MoyErrPerc(i) = ((C1ErreurPerc(i) * length(TestC1)) + (C2ErreurPerc(i) * length(TestC2))) ./ (length(TestC1) + length(TestC2));
    
    % Moindre Carré
    Z = Y';
    b = ones(length(Z), 1);
    
    Wn = Z\b;
    W0 = Wn(1,1);
    W = Wn(2:length(Wn),:);
    
    ResMCC1 = MalClasse(YC1, [W0; W]);
    ResMCC2 = MalClasse(YC2, [W0; W]);
    
    C1ErreurMC(i) = length(ResMCC1) ./ (length(TestC1) + length(TestC2));
    C2ErreurMC(i) = length(ResMCC2) ./ (length(TestC1) + length(TestC2));
    MoyErrMC(i) = (C1ErreurMC(i) * length(TestC1) + (C2ErreurMC(i) * length(TestC2))) ./ (length(TestC1) + length(TestC2));
    
    % Moindre Carré Opti
    
    bmco = ones(length(Z),1);
    
    Wn= MCOpti(Z,bmco);
    W0Opt = Wn(1,1);
    WOpt = Wn(2:length(Wn),:);
    
    ResMCOC1 = MalClasse(YC1, [W0Opt;WOpt]);
    ResMCOC2 = MalClasse(YC2, [W0Opt;WOpt]);
    
    C1ErreurMCO(i) = length(ResMCC1) ./ (length(TestC1) + length(TestC2));
    C2ErreurMCO(i) = length(ResMCC2) ./ (length(TestC1) + length(TestC2));
    MoyErrMCO(i) = (C1ErreurMC(i) * length(TestC1) + (C2ErreurMC(i) * length(TestC2))) ./ (length(TestC1) + length(TestC2));
    
end;

%% Affichage des erreurs
%MAP
figure('Name','Erreur');
hold on
plot(1:nbIter,nbC1Erreur,'b')
plot(1:nbIter,nbC2Erreur, 'r')
plot(1:nbIter, erreurmoyenne,'g')
hold off

%Perceptron
figure('Name', 'Erreur Perceptron');
hold on
plot(1:nbIter, C1ErreurPerc,'b');
plot(1:nbIter, C2ErreurPerc,'r');
plot(1:nbIter, MoyErrPerc,'g');
hold off

%Moindre Carré
figure('Name', 'Erreur MC');
hold on
plot(1:nbIter, C1ErreurMC,'b');
plot(1:nbIter, C2ErreurMC,'r');
plot(1:nbIter, MoyErrMC,'g');
hold off

%Moindre Carré
figure('Name', 'Erreur MC Opti');
hold on
plot(1:nbIter, C1ErreurMCO,'b');
plot(1:nbIter, C2ErreurMCO,'r');
plot(1:nbIter, MoyErrMCO,'g');
hold off