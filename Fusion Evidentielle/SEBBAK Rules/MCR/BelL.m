function [Masse]=BelL(MasseIn)
[n,m]=size(MasseIn);

% Calcul des somme des chaque element focal
somme_masses =  sum(MasseIn');

Masse=somme_masses./m;
 
 
 

