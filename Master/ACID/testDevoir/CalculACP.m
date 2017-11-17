function [ V , C , moy] = CalculACP( echantillon)
%CALCULACP Summary of this function goes here
%   Retourne la matrice trié des vecteur propre, les echantillons
%   recentrés et la moyenne des echantillons

moy = mean(echantillon); %Calcul de la moyenne des echantillons 
C = echantillon - repmat(moy,size(echantillon, 1), 1); %Recentre les échantillons par rapport à la moyenne

S = (size(C,1)-1) * cov(C); % calcul la matrice de covariance des echantillons centrés 
%(size(C,1)-1) ne sert à rien ici, c'est surtout dans le cas ou on voudrati
%comparer deux matrice de covariance il faut qu'elles ai la même taille

[e lambda] = eig(S) % calcul des vecteur propre (e) et des valeur propre (lambda)
diagonal = diag(lambda) % On recupére la diagonal des valeur propres car c'est ce qui nous interresse 
[tri Itri] = sort(diagonal,'descend'); % On tri du plus grand au plus petit les valeurs propres

vtri = e;
for i = 1:length(lambda)
vtri(:,i) = e(:,Itri(i)); % On tri les vecteurs propres en fonction des valeur propres 
%grace à Itri qui contient les indices triés des valeurs propres triés
end

e
V = vtri

end

