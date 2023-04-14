function [ F1_Score_Class,F1_Score_Totat, TMBC,TMBC_Class ] = transf_Confus_Coeff( ConfM )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%[~,F1_Score_Totat, TMBC,~ ]=transf_Confus_Coeff(mat)

recall=ones((power(2,size(ConfM,1))-1),1);
TMBC=0;
precision=ones((power(2,size(ConfM,1))-1),1);
F1_Score_Class=ones((power(2,size(ConfM,1))-1),1);

if(size(ConfM,1)==3)
    
    
    for i=1:size(ConfM,1)
        
        recall(i)=ConfM(i,i)/sum(ConfM(i,:));
        
        if (sum(ConfM(:,i)) ~= 0 )
            precision(i)=ConfM(i,i)/sum(ConfM(:,i));
        else
            precision(i)=0;
        end
        TMBC=TMBC+recall(i);
    end
    
    
    
    recall(4)= (ConfM(1,1)+ConfM(1,2)+ConfM(2,1)+ConfM(2,2))/(sum(ConfM(1,:))+sum(ConfM(2,:)));
    if ((sum(ConfM(:,1))+sum(ConfM(:,2))) ~= 0 )
        precision(4)=(ConfM(1,1)+ConfM(1,2)+ConfM(2,1)+ConfM(2,2))/(sum(ConfM(:,1))+sum(ConfM(:,2)));
    else
        precision(4)=0;
    end
    
    recall(5)= (ConfM(1,1)+ConfM(1,3)+ConfM(3,1)+ConfM(3,3))/(sum(ConfM(1,:))+sum(ConfM(3,:)));
    if ((sum(ConfM(:,1))+sum(ConfM(:,3))) ~= 0 )
        precision(5)= (ConfM(1,1)+ConfM(1,3)+ConfM(3,1)+ConfM(3,3))/(sum(ConfM(:,1))+sum(ConfM(:,3)));
    else
        precision(5)=0;
    end
    
    
    recall(6)= (ConfM(2,2)+ConfM(2,3)+ConfM(3,2)+ConfM(3,3))/(sum(ConfM(2,:))+sum(ConfM(3,:)));
    if ((sum(ConfM(:,2))+sum(ConfM(:,3))) ~= 0 )
        precision(6)=(ConfM(2,2)+ConfM(2,3)+ConfM(3,2)+ConfM(3,3))/(sum(ConfM(:,2))+sum(ConfM(:,3)));
    else
        precision(6)=0;
    end
    
else
    if(size(ConfM,1)==2)
        
        for i=1:size(ConfM,1)
            
            recall(i)=ConfM(i,i)/sum(ConfM(i,:));
            if (sum(ConfM(:,i)) ~= 0 )
                precision(i)=ConfM(i,i)/sum(ConfM(:,i));
            else
                precision(i)=0;
            end
            TMBC=TMBC+recall(i);
        end
        
    end
end
for t=1:(power(2,size(ConfM,1))-1)
    if ((recall(t)+precision(t)) ~= 0 )
    F1_Score_Class(t)=(2*recall(t)*precision(t))/(recall(t)+precision(t)) ;
    else
      F1_Score_Class(t)=0;
    end
end
F1_Score_Totat=(2*mean(recall)*mean(precision))/(mean(recall)+mean(precision)) ;
TMBC=TMBC/size(ConfM,1);
TMBC_Class=recall;
end



