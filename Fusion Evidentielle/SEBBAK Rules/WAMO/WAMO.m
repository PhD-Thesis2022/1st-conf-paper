function [Masse]=WAMO(MasseIn,criteria)
%Référence: Faouzi Sebbak, F Benhammadi, A Chibani, Y Amirat, and A Mokhtari. New evidence combination rules for activity recognition in smart home. In the 16th International Conference on Information  Fusion (FUSION 2013), pages 46–52, IEEE, July 2013.

%MasseIn: nb of masses = nb column
%         1column=1 masse
%         criteria = is the number of method to be used
%                   criteria=1 method 1
%                   criteria=2 method 2
%                   criteria=3 method 3


switch criteria

    case 1
        [Masse]= Mean_M1(MasseIn);
    case 2
        [Masse]= MeanConsensus(MasseIn);
    case 3
        [Masse]= Mean(MasseIn);  
end
