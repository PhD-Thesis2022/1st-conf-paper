function [ MASS ] = weaken( massTab , coeff )
%weaken computes the resulting masse fonction after using the weakening
%coefficient 
%
% INPUT
% masseTab  The original mass fonction
% coeff     The weakening coefficients
%
% OUTPUT
% MASS      The weakened mass fonction

lastLine = size(massTab,1); % the index of the ignorance set
MASS = massTab;

for i = 1 : size(coeff)
    X = ( 1 - coeff(i) ) + coeff(i)*massTab(lastLine,i);
    MASS(:,i) = coeff(i)*massTab(:,i);
    MASS(lastLine,i) = X;
end

end

