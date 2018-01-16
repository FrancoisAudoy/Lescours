function [ TrainC2,TestC2,TrainC1, TestC1] = extractTestAndTrainN(C2, C1, sizeTrainC2, sizeTrainC1)

    sizeC2 = size(C2,1);
    sizeC1 = size(C1,1);
    
    C2Indice          = randperm(sizeC2);
    TrainC2Indice     = C2Indice(1:sizeTrainC2);
    TestC2Indice      = C2Indice(sizeTrainC2+1:sizeC2);
    
    C1Indice          = randperm(sizeC1);
    TrainC1Indice     = C1Indice(1:sizeTrainC1);
    TestC1Indice      = C1Indice(sizeTrainC1+1:sizeC1);
    
    TrainC1  = C1(TrainC1Indice,:);
    TrainC2  = C2(TrainC2Indice,:);
    
    TestC1  =  C1(TestC1Indice,:);
    TestC2  =  C2(TestC2Indice,:);

end

