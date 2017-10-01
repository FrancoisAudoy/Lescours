% Régression Linéaire 
m = 40;
sizeNoise = 10;
x = rand(m,1).*50 + 5;
noise = rand(m,1) * sizeNoise;
pente = 0.8;
c =  20;
y = c + pente*x + noise;

T1 = (m * sum(x.*y) - sum(sum(x)*sum(y))) / (m * sum(x.*x) - (sum(x) * sum(x)))
T0 = (sum(y) - T1 * sum(x)) / m 
yi = T1*x +T0;

s = sum(((T0 + T1*x - yi)*(T0 + T1*x - yi)),length(x));

figure('Name','Nuage de points + regression lineaire')
hold on 
scatter(x,y)
plot(x,s)% (T0 + (T1.*x)))
hold off