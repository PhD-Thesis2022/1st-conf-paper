function [Masse]=MCR(MasseIn)
%Référence: Faouzi Sebbak, Farid Benhammadi: Majority-consensus fusion approach for elderly IoT-based healthcare applications. Annals of telecommunications 72(3-4): 157-171, 2017, DOI: 10.1007/s12243-016-0550-7.

[n,m]=size(MasseIn);
Final_Masses = repmat(0,1,n);



% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));

% Calcul des produit conjunctives et du conflit pour les nouvelles masses
[conjunctive_masses Conflict] = Conjunction_and_Conflict(MasseIn);


% Calcul des somme des chaque element focal
somme_masses =  sum(MasseIn');

Final_Masses = conjunctive_masses + somme_masses;

Final_Masses =Final_Masses ./(m+(1-Conflict));

Masse=Final_Masses;
end