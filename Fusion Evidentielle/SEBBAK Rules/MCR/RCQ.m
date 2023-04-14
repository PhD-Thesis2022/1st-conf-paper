function [RCQ_value]=RCQ(Result_Rule,MasseIn)
%   clc

[n,m]=size(MasseIn);
taille_discernement=(log2(n));

BeliefL = BelL(MasseIn);
PlausibiliteU = PlU(MasseIn);
BetP = decisionDST_with_Masses_values(Result_Rule',4);

somme_dist=0;
for i=1:taille_discernement
    dist=0;
    if (BetP(i) < BeliefL( (2^(i-1))+1) )
        dist =  BeliefL( (2^(i-1))+1) - BetP(i);
    end
    if (BetP(i) > PlausibiliteU( (2^(i-1))+1) )
        dist =  BetP(i) - PlausibiliteU( (2^(i-1))+1) ;
    end

    somme_dist = somme_dist + dist;
end

somme_dist= somme_dist / taille_discernement;
RCQ_value = 1 - somme_dist ;