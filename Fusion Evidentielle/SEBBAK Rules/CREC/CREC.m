function [Masse]=CREC(MasseIn)
%Référence: Faouzi Sebbak, Farid Benhammadi, M'hamed Mataoui, Sofiane Bouznad, Yacine Amirat: An alternative combination rule for evidential reasoning. In the 17th International Conference on Information Fusion (FUSION 2014), pages 1–8, IEEE, July 2014.

[n,m]=size(MasseIn);
Final_Masses = repmat(0,1,n);

% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));

% Calcul des produit conjunctives avec cardinality
conjunctive_weigted_masses=repmat(0,1,n);
conjunctive_weigted_masses = get_Weighted_Conjunctive(MasseIn);

Somme_conj_card=0; 
for x1=1:n
        Somme_conj_card = Somme_conj_card + conjunctive_weigted_masses(x1);
    end
Conflict = 1- Somme_conj_card;
 
resultat_of_weight = repmat(0,1,n);
resultat_final = repmat(0,1,n);
for i=2:n
    resultat = repmat(0,m,n);
    
    % Ajouter les mi(X)     
     for j=1:m
        resultat(j,i)= MasseIn(i,j);
     end
      
     for j=2:n
        for v=1:n
            if(get_Intersect_Focal(j,v) ~= i)
                t_vecteur(v) = 0;
            else
                t_vecteur(v) = 1;
            end
        end
        
        for source=1:m
            if(MasseIn(j,source)~=0)
                nbre=1;
                for k=1:m
                    if (k ~= source) 
                        masse2(:,nbre) = t_vecteur'.* MasseIn(:,k);
                        nbre=nbre+1;
                    end
                end
                exist = exist_produit_not_null(masse2);
              
                if (exist ~=0)
                    for i1=1:n
                        indice_mm=1;
                        for i2=1:m
                            if(i2 ~= source)
                                if(masse2(i1,indice_mm) ~= 0)
                                    if( i ~= i1)
                                       resultat(i2,i1) = masse2(i1,indice_mm)*(get_Cardinality(i)/get_Cardinality(i1));
                                    else
                                        resultat(i2,i1) = masse2(i1,indice_mm);
                                    end
                                end
								indice_mm = indice_mm+1;
                            end
                        end
                    end
                end
            end
        end
     end
%   resultat
    resultat_of_weight(i) = sum(sum(resultat));
end


 lambda = sum(resultat_of_weight);
for i=1:n
     resultat_of_weight(i)= resultat_of_weight(i)/lambda;
end

for i=1:n
     resultat_final(i)= conjunctive_weigted_masses(i)+(Conflict * resultat_of_weight(i));
end

Masse=resultat_final;
end