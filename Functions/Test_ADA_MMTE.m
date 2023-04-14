function [ moy ] = Test_ADA_MMTE( a,app,test,Attribute_Coeff,F1_Score_Class,F1_Score_Totat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

appData = app.data;
testData = test.data;
Nbre_Classiefieur=sum(Attribute_Coeff(:,1)~=0);
massTab_Ada=zeros(power(2,getsize(a,3))-1,Nbre_Classiefieur);

% les probabilites a prio

if( getsize(a,3) == 3)
    cs=[sum(getnlab(app)==1),sum(getnlab(app)==2),sum(getnlab(app)==3)];
else if ( getsize(a,3) == 2)
        cs=[sum(getnlab(app)==1),sum(getnlab(app)==2)];
    end
end

% f is the massTab after the normalisation <<< important <<<
f = zeros(getsize(test,1) , getsize(a,2) , 2^getsize(a,3)-1);

if( getsize(a,3) == 3) %on a 3 classes
    for i = 1 : getsize(a,2)
        f(:,i,1) = ksdensity(appData(getnlab(app)==1,i),testData(:,i));
        f(:,i,2) = ksdensity(appData(getnlab(app)==2,i),testData(:,i));
        f(:,i,3) = ksdensity(appData(getnlab(app)==3,i),testData(:,i));
        f(:,i,4) = (cs(1)/(cs(1)+cs(2)))*f(:,i,1)+(cs(2)/(cs(1)+cs(2)))*f(:,i,2);
        f(:,i,5) = (cs(1)/(cs(1)+cs(3)))*f(:,i,1)+(cs(3)/(cs(1)+cs(3)))*f(:,i,3);
        f(:,i,6) = (cs(2)/(cs(2)+cs(3)))*f(:,i,2)+(cs(3)/(cs(2)+cs(3)))*f(:,i,3);
        f(:,i,7) =(cs(1)/sum(cs))*f(:,i,1)+(cs(2)/sum(cs))*f(:,i,2)+(cs(3)/sum(cs))*f(:,i,3);
    end
    
else if ( getsize(a,3) == 2) %on a 2 classes
        for i = 1 : getsize(a,2)
            f(:,i,1) = ksdensity(appData(getnlab(app)==1,i),testData(:,i));
            f(:,i,2) = ksdensity(appData(getnlab(app)==2,i),testData(:,i));
            f(:,i,3) = (cs(1)/sum(cs))*f(:,i,1)+(cs(2)/sum(cs))*f(:,i,2);
        end
    end
end


% la normalisation
S=sum(f,3);
for i=1:2^getsize(a,3)-1
    f(:,:,i)=f(:,:,i)./S;
end

Y_Test = zeros(getsize(test,1),1);

for i = 1 : getsize(test,1)
    masseTab= reshape(f(i,:,:),getsize(a,2),2^getsize(a,3)-1)';
    
    
    %Affaiblissement
    if nargin > 4
        F1_Score_Totat=F1_Score_Totat-min(F1_Score_Totat)*ones(size(F1_Score_Totat));
        masseTab=masseTab.*F1_Score_Class;
        
        for b=1:getsize(a,2)
            v=(1-F1_Score_Class(:,b)).*masseTab(:,b);
            masseTab((power(2,getsize(a,3))-1),b)=masseTab((power(2,getsize(a,3))-1),b)+sum(v);
            for r=1:power(2,getsize(a,3))-2
                masseTab(r,b)= masseTab(r,b) + F1_Score_Totat(b)*masseTab((power(2,getsize(a,3))-1),b)*masseTab(r,b)/(1-masseTab((power(2,getsize(a,3))-1),b));
            end
            masseTab((power(2,getsize(a,3))-1),b)= (1-F1_Score_Totat(b)) *masseTab((power(2,getsize(a,3))-1),b);
            
        end
    end
    
    
    for g=1:Nbre_Classiefieur
        massTab_Ada(:,g) = Attribute_Coeff(g,2)*masseTab(:,Attribute_Coeff(g,1));
    end
    
    if( getsize(a,3) == 3) %on a 3 classes
        
        [~,Y_Test(i)] = max(pignistique(fusion(massTab_Ada)));
        
    else if ( getsize(a,3) == 2) %on a 2 classes
            
            [~,Y_Test(i)] = max(pignistique2(fusion2(massTab_Ada)));
        end
    end
    
end

moy = sum(Y_Test == getnlab(test))/getsize(test,1);

end



