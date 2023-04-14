function [val]= Calcul_Conjunctive_somme_element(MasseIn, elements)


[n,m]=size(MasseIn);
s= size(elements );
s1=s(1) ;
s2=s(2) ;
mul=1;
indice=1;
for i=1:s2
    MasseIn(elements(i),indice);
    mul=mul *     MasseIn(elements(i),indice);
    indice=indice+1;
end
val=mul;