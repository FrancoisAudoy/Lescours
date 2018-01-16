function [model] = TrainModel (Train)

model.mu = mean(Train);
model.sigma = eye(size(Train,2)).*sqrt(var(Train));

end
