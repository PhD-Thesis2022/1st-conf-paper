function [Masse]=TCR1(MasseIn)
%Référence: Faouzi Sebbak, M'hamed Mataoui, Farid Benhammadi: A New Combination Rule Based on a Total Conflict Redistribution. 1ère Conférence sur l'Ingénierie Informatique (C2i), 16-17 Décembre 2014.
[n,m]=size(MasseIn);

% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));


%calcul du produit conjunctive et le conflict
[conjunctive_masses Conflict] = Conjunction_and_Conflict(MasseIn);

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
%     i
%  resultat
    resultat_final(i) = sum(sum(resultat));
end


lambda = sum(resultat_final);
for i=1:n
     resultat_final(i)= resultat_final(i)/lambda;
end

for i=1:n
     resultat_final(i)= conjunctive_masses(i)+(Conflict * resultat_final(i));
end

Masse = resultat_final;




