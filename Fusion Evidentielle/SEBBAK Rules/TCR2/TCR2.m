function [Masse]=TCR2(MasseIn)
%Référence : Faouzi Sebbak, Farid Benhammadi: Total conflict redistribution rule for evidential fusion. In the 19th International Conference on Information Fusion (FUSION 2016), pages 1324-1331, IEEE, July 2016.

[n,m]=size(MasseIn);


% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));

%calcul du produit conjunctive et le conflict
[conjunctive_masses Conflict] = Conjunction_and_Conflict(MasseIn);



weight = repmat(0,1,n);
resultat_final = repmat(0,1,n);

conjunctive_distance_masses=repmat(0,1,n);
conjunctive_distance_masses = get_Weighted_Conjunctive(MasseIn);



weight= conjunctive_distance_masses;

for i=2:n
    % Ajouter les mi(X)     
     for j=1:m
        weight(i)= weight(i)+ MasseIn(i,j);
     end
 end
  
 



lambda = sum(weight);
for i=1:n
     weight(i)= weight(i)/lambda;
end

for i=1:n
     resultat_final(i)= conjunctive_masses(i)+(Conflict * weight(i));
end


Masse = resultat_final;



