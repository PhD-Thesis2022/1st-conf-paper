function [Masse]=MeanConsensus(MasseIn)
%Référence: Faouzi Sebbak, F Benhammadi, A Chibani, Y Amirat, and A Mokhtari. New evidence combination rules for activity recognition in smart home. In the 16th International Conference on Information  Fusion (FUSION 2013), pages 46–52, IEEE, July 2013.

%WAMO_2 Method 2

[n,m]=size(MasseIn);
masse_Distribution = repmat(0,1,n);


Consensus = min(MasseIn');
Sum_Consensus =  sum(MasseIn');

new_Conflict = 1- sum(Consensus);
zero_Consensus= repmat(0,1,n);

for i=1:m
    vec = MasseIn(:,i);
    for j=2:n
        if(vec(j) == Consensus(j))
            zero_Consensus(j) = zero_Consensus(j) + 1 ;
        end
    end
    
end

for i=1:n
    if(zero_Consensus(i) ~= m)
        zero_Consensus(i)= 1;
    else
        zero_Consensus(i)=0;
    end
end

Sum_Consensus = Sum_Consensus.*zero_Consensus;
Sum_Consensus = Sum_Consensus / sum(Sum_Consensus);

for i=2:n
    masse_Distribution(i) = Consensus(i)+ Sum_Consensus(i)* new_Conflict;
end
Masse=masse_Distribution;