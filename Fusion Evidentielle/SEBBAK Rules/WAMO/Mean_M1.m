function [Masse]=Mean_M1(MasseIn)
%Référence: Faouzi Sebbak, F Benhammadi, A Chibani, Y Amirat, and A Mokhtari. New evidence combination rules for activity recognition in smart home. In the 16th International Conference on Information  Fusion (FUSION 2013), pages 46–52, IEEE, July 2013.

%WAMO_1   Method1

[n,m]=size(MasseIn);
masse_Distribution = repmat(0,1,n);


Consensus = min(MasseIn');
new_Conflict = 1- sum(Consensus);

Sum_Masses =  sum(MasseIn');
Mean_Sum_Masses = Sum_Masses ./m;

for i=2:n
    masse_Distribution(i) = Consensus(i)+ Mean_Sum_Masses(i)* new_Conflict;
end
Masse=masse_Distribution;