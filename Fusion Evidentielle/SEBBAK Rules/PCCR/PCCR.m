function [Masse]=PCCR(MasseIn)
%Référence: Faouzi Sebbak, Farid Benhammadi, M'hamed Mataoui, Kada Beghdad Bey: Evidence-fuzzy system for human concurrent activities recognition. In  IEEE International Conference on Fuzzy Systems (FUZZ-IEEE 2015), pages 1-6, August 2015, DOI: 10.1109/FUZZ-IEEE.2015.7337947

[n,m]=size(MasseIn);

% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));


Final_Masses= repmat(0,1,n);
tab_inter = [];
tab_conflict = get_Conflict_Matrix(MasseIn,tab_inter);
tab_Consensus = get_Consensus_Matrix(MasseIn,tab_inter);

new_tab_conflict = tab_conflict;
new_tab_consensus = tab_Consensus;

%calcul des alphas
s= size(new_tab_consensus );
s1=s(1);
s2=s(2) ;

alpha = repmat(0,1,n);
for k=1:s1
    lambda=0;
    w123=[];
    alpha=repmat(0,1,n);
    for i=1:s2
        alpha(new_tab_consensus(k,i)) = alpha(new_tab_consensus(k,i)) + MasseIn(new_tab_consensus(k,i),i);
    end
    lambda = sum(alpha);
    normalized_alpha =[];
    
    for i=1:length(alpha)
        normalized_alpha(i)=alpha(i)/lambda;
    end
    for i=1:length(alpha)
        Final_Masses(i) = Final_Masses(i)+  normalized_alpha(i)* Calcul_Conjunctive_somme_element(MasseIn,new_tab_consensus(k,:));
    end
end



%calcul des betas
s= size(new_tab_conflict );
s1=s(1);
s2=s(2) ;

beta = repmat(0,1,n);
for k=1:s1
    lambda=0;
    w123=[];
    beta=repmat(0,1,n);
    for i=1:s2
        beta(new_tab_conflict(k,i)) = beta(new_tab_conflict(k,i)) + MasseIn(new_tab_conflict(k,i),i);
    end
    lambda = sum(beta);
    normalized_beta =[];
    
    for i=1:length(beta)
        normalized_beta(i)=beta(i)/lambda;
    end
    for i=1:length(beta)
        Final_Masses(i) = Final_Masses(i)+  normalized_beta(i)* Calcul_Conjunctive_somme_element(MasseIn,tab_conflict(k,:));
    end
end

Masse = Final_Masses;

