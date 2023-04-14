function [Masse]=CRC(MasseIn)
%Référence : Faouzi Sebbak, Farid Benhammadi, Sofiane Bouznad, Abdelghani Chibani, Yacine Amirat: An Evidential Fusion Rule for Ambient Intelligence for Activity Recognition. In the Third International Conference on Belief Functions (Belief Functions 2014), pages 356-364, Oxford, UK, September 2014, DOI: 10.1007/978-3-319-11191-9_39.

[n,m]=size(MasseIn);
Weighted_Masses = repmat(0,n,m);
Final_Masses = repmat(0,1,n);


% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));

%  Calcul des nouvelles weighted masses
for i=2:n
    for j=1:m
        sum = 0;
        for k=1:m
            if(k ~= j)
                sum = sum + MasseIn (i, k);
            end
        end
        Weighted_Masses(i,j)=  (MasseIn (i,j) + (sum /(m-1)))/2;
    end
end 
    
% Calcul des produits conjunctives et du conflit pour les nouvelles masses
[conjunctive_masses Conflict] = Conjunction_and_Conflict(Weighted_Masses);

conjunctive_weigted_masses=repmat(0,1,n);
conjunctive_weigted_masses = get_Weighted_Conjunctive(Weighted_Masses);

  lambda=0;
    for x1=1:n
        lambda = lambda + conjunctive_weigted_masses(x1);
    end
    
    for x1=1:n
        conjunctive_weigted_masses(x1) = conjunctive_weigted_masses(x1) / lambda;
    end
    
     for x1=1:n
        Final_Masses(x1) = conjunctive_masses(x1) + conjunctive_weigted_masses(x1)*Conflict;
     end

Masse=Final_Masses;
