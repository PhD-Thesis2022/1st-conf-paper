function [Masse]=Murphy(MasseIn)
[n,m]=size(MasseIn);
Vecteur_Moyenne = repmat(0,n,1);
         
for j=2:n
      Vecteur_Moyenne(j)=mean(MasseIn(j,:));
end

Matrice_pour_DS = repmat(0,n,m);
for i=1:m   
      Matrice_pour_DS(:,i)=  Vecteur_Moyenne;
end

Masse=DST(Matrice_pour_DS,2);