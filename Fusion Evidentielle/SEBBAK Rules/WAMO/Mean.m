function [Masse]=Mean(MasseIn)
%Référence: Faouzi Sebbak, F Benhammadi, A Chibani, Y Amirat, and A Mokhtari. New evidence combination rules for activity recognition in smart home. In the 16th International Conference on Information  Fusion (FUSION 2013), pages 46–52, IEEE, July 2013.

%WAMO_3 Method 3
[n,m]=size(MasseIn);
masse_Distribution = repmat(0,1,n);


% Calcul des Min
Min_Matrix = repmat(0,1,n)';
Min_Matrix = min(MasseIn');
Somme_Matrix =  sum(MasseIn');

new_Conflict = 1- sum(Min_Matrix);

new_masse = Somme_Matrix - m * Min_Matrix;

new_masse = new_masse / sum(new_masse);
for i=2:n
    masse_Distribution(i) = Min_Matrix(i)+ new_masse(i)* new_Conflict;
end
Masse=masse_Distribution;