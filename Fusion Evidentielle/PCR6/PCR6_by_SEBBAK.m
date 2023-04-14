function [Masse]=PCR6_by_SEBBAK(MasseIn)
%this is sebbak's implementation of PCR combination Rule
[n,m]=size(MasseIn);

% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));

%calcul du produit conjunctive et le conflict
[conjunctive_masses Conflict] = Conjunction_and_Conflict(MasseIn);


Final_Masses= repmat(0,1,n);
tab_inter = [];
tab_conflict = get_Conflict_Matrix(MasseIn,tab_inter);

%  new_tab_conflict=del_Elem_Not_In_Conf(tab_conflict,taille_discernement);
new_tab_conflict = tab_conflict;

s= size(new_tab_conflict );
s1=s(1); 
s2=s(2) ;

%calcul du poids
weight = repmat(0,1,n);
for k=1:s1
    lambda=0;
    w123=[];
    weight=repmat(0,1,n);
    for i=1:s2
        weight(new_tab_conflict(k,i)) = weight(new_tab_conflict(k,i)) + MasseIn(new_tab_conflict(k,i),i);
    end
    lambda = sum(weight);
    normalized_weight =[];
    
    for i=1:length(weight)
        normalized_weight(i)=weight(i)/lambda;
    end
    for i=1:length(weight)
        Final_Masses(i) = Final_Masses(i)+  normalized_weight(i)* Calcul_Conjunctive_somme_element(MasseIn,tab_conflict(k,:));
    end
end
Final_Masses = Final_Masses + conjunctive_masses;
Masse = Final_Masses;

