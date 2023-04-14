function [ M ] = fusion2( mTab )
%fusion calculates the masse of each set of the mTab
%using the Dempster's rule of combinaison
m = mTab(:,1);
if(size(mTab,2)==1)
    M =mTab;
else
    M = zeros(3,1);
    for i = 2 : size(mTab,2)
        M(1) = m(1)*(mTab(1,i)+mTab(3,i)) + mTab(1,i)*m(3);
        M(2) = m(2)*(mTab(2,i)+mTab(3,i)) + mTab(2,i)*m(3);
        M(3) = m(3)*mTab(3,i);
        M = M/sum(M);
        m = M;
    end
end

end