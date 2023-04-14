clear;
clc;

N=10;
Iter_nbre=10;
%tableau = zeros(9,4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = wine;
%a=load_prdataset('australian.dat',15,15,1,13);
%disp('australian');


F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
F1_Score_Totat=zeros(1,getsize(a,2));
f1_Score_Totat=zeros(1,getsize(a,2));
tmbc=zeros(1,getsize(a,2));
TMBC=zeros(1,getsize(a,2));
TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));

for o=1:Iter_nbre
    
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i) );
[ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
TMBC=TMBC+tmbc;
TMBC_Class=TMBC_Class+tmbc_Class;
ConfMatrix=ConfMatrix+ConfMat;
end

TMBC=TMBC/Iter_nbre;
F1_Score_Totat=F1_Score_Totat/Iter_nbre;
TMBC_Class=TMBC_Class/Iter_nbre;
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;

tab=zeros(1,3);
moy=0;
moy1=0;
moy2=0;
for i=1:N
    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
 [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,10 );
 tab(1,1)=moyenne;
 moy=moy+moyenne;
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,F1_Score_Class,F1_Score_Totat,ConfMatrix );
tab(1,2)=moyenne1;
moy1=moy1+moyenne1;
[ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,TMBC_Class,F1_Score_Totat,ConfMatrix );
tab(1,3)=moyenne2
moy2=moy2+moyenne2;

end
Moy_SANS_=moy/N;
Moy_F1_Score_Class_=moy1/N;
Moy_TMBC_Class_=moy2/N;
tab(1,1)=Moy_F1_Score_Class_;
tab(1,2)=Moy_TMBC_Class_;
tab(1,3)=Moy_SANS_;
tab'


% moy=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %%[ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,F1_Score_Class,TMBC );
% moy=moy+moyenne;
% end
% tableau(1,2)=moy/N%Moy_F1_Score_Class_TMBC=moy/N
% 
% moy=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,TMBC_Class,F1_Score_Totat );
% moy=moy+moyenne;
% end
% tableau(1,3)=moy/N%Moy_TMBC_Class_F1_Score_Totat=moy/N
% 
% moy=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %%[ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,TMBC_Class,TMBC );
% moy=moy+moyenne;
% end
% tableau(1,4)=moy/N%Moy_TMBC_Class_TMBC_Totat=moy/N

