function [ Class_Error ] = Erreur_ADA_MMTE( a,F1_Score_Class )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data = a.data;
NC=getsize(a,3);
NO=getsize(a,1);
f = zeros(NO , 2^NC-1);
Y_Test = zeros(NO,1);
if( NC == 3)
    cs=[sum(getnlab(a)==1),sum(getnlab(a)==2),sum(getnlab(a)==3)];
    f(:,1) = ksdensity(Data(getnlab(a)==1,1),Data(:,1));
    f(:,2) = ksdensity(Data(getnlab(a)==2,1),Data(:,1));
    f(:,3) = ksdensity(Data(getnlab(a)==3,1),Data(:,1));
    f(:,4) = (cs(1)/(cs(1)+cs(2)))*f(:,1)+(cs(2)/(cs(1)+cs(2)))*f(:,2);
    f(:,5) = (cs(1)/(cs(1)+cs(3)))*f(:,1)+(cs(3)/(cs(1)+cs(3)))*f(:,3);
    f(:,6) = (cs(2)/(cs(2)+cs(3)))*f(:,2)+(cs(3)/(cs(2)+cs(3)))*f(:,3);
    f(:,7) =(cs(1)/sum(cs))*f(:,1)+(cs(2)/sum(cs))*f(:,2)+(cs(3)/sum(cs))*f(:,3);
    
    S=sum(f,2);
    S=repmat(S,1,2^NC-1);
    f=f./S;
    
    %Affaiblissement
    if nargin > 2
        
        f=f.*repmat(F1_Score_Class',NO,1);
        v=f.*repmat((1-F1_Score_Class)',NO,1);
        f(:,(power(2,NC)-1))=f(:,(power(2,NC)-1))+sum(v,2);
    end
    
    
    for i = 1 : NO
        [~,Y_Test(i)] = max(pignistique(f(i,:)));
    end
    
else if ( NC == 2)
        cs=[sum(getnlab(a)==1),sum(getnlab(a)==2)];
        f(:,1) = ksdensity(Data(getnlab(a)==1,1),Data(:,1));
        f(:,2) = ksdensity(Data(getnlab(a)==2,1),Data(:,1));
        f(:,3) = (cs(1)/sum(cs))*f(:,1)+(cs(2)/sum(cs))*f(:,2);
        
        S=sum(f,2);
        S=repmat(S,1,2^NC-1);
        f=f./S;
        
        if nargin > 2
            
            f=f.*repmat(F1_Score_Class',NO,1);
            v=f.*repmat((1-F1_Score_Class)',NO,1);
            f(:,(power(2,NC)-1))=f(:,(power(2,NC)-1))+sum(v,2);
        end
        
        
        for i = 1 : NO
            [~,Y_Test(i)] = max(pignistique2(f(i,:)));
        end
    end
end

Class_Error= Y_Test ~= getnlab(a);

end





