function [ M ] = fusion( mTab )
%fusion calculates the masse of each set of the mTab 
%using the Dempster's rule of combinaison
    m = mTab(:,1);
    if(size(mTab,2)==1) 
        M =mTab;
    else
    M = zeros(7,1);
    for i = 2 : size(mTab,2)
        
        M(1) = m(1)*(mTab(1,i)+mTab(4,i)+mTab(5,i)+mTab(7,i)) + mTab(1,i)*(m(4)+m(5)+m(7)) + m(4)*mTab(5,i) + mTab(4,i)*m(5);
        M(2) = m(2)*(mTab(2,i)+mTab(4,i)+mTab(6,i)+mTab(7,i)) + mTab(2,i)*(m(4)+m(6)+m(7)) + m(4)*mTab(6,i) + mTab(4,i)*m(6); 
        M(3) = m(3)*(mTab(3,i)+mTab(5,i)+mTab(6,i)+mTab(7,i)) + mTab(3,i)*(m(5)+m(6)+m(7)) + m(5)*mTab(6,i) + mTab(5,i)*m(6);      
        M(4) = m(4)*(mTab(4,i)+mTab(7,i)) + mTab(4,i)*m(7);
        M(5) = m(5)*(mTab(5,i)+mTab(7,i)) + mTab(5,i)*m(7);
        M(6) = m(6)*(mTab(6,i)+mTab(7,i)) + mTab(6,i)*m(7);
        M(7) = m(7)*mTab(7,i);
        M = M/sum(M);
        m = M;
    end
    end
end

