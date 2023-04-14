clear;
%clc;
%a=load_prdataset('australian.dat',15,15,1,14);

                
                %  @SigmoidFunction     @Logistic  


N=20;
Iter_nbre=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tab_total_box = zeros(6,5);
kernel='Triweight';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

app = load_prdataset('KDDTrain+_20Percent.dat',42,42,1,41);
test= load_prdataset('KDDTest-21.dat',42,42,1,41);

a = [app;test];




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
'first loop'
for o=1:Iter_nbre
    
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
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
'second loop'
tab=zeros(1,5);
moy=0;
moy1=0;
moy2=0;
moy3=0;
moy4=0;
for i=1:N
    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
 [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
 tab(1,1)=moyenne;
 moy=moy+moyenne;
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
tab(1,2)=moyenne1
moy1=moy1+moyenne1;
[ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
tab(1,3)=moyenne2;
moy2=moy2+moyenne2;
[ moyenne3 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,TMBC,ConfMatrix );
tab(1,4)=moyenne3;
moy3=moy3+moyenne3;
[ moyenne4 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,TMBC,ConfMatrix );
tab(1,5)=moyenne4;
moy4=moy4+moyenne4;

end
Moy_SANS_=moy/N;
Moy_F1_Score_Class_F1_Score_Totat=moy1/N;
Moy_TMBC_Class_F1_Score_Totat=moy2/N;
Moy_F1_Score_Class_TMBC=moy3/N;
Moy_TMBC_Class_TMBC=moy4/N;
tab_total_box(1,1)=Moy_SANS_;
tab_total_box(1,2)=Moy_F1_Score_Class_F1_Score_Totat;
tab_total_box(1,3)=Moy_TMBC_Class_F1_Score_Totat;
tab_total_box(1,4)=Moy_F1_Score_Class_TMBC;
tab_total_box(1,5)=Moy_TMBC_Class_TMBC;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = heart;
% 
% disp('heart');
% 
% 
% F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% F1_Score_Totat=zeros(1,getsize(a,2));
% f1_Score_Totat=zeros(1,getsize(a,2));
% tmbc=zeros(1,getsize(a,2));
% TMBC=zeros(1,getsize(a,2));
% TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% 
% for o=1:Iter_nbre
%     
% for i=1:getsize(a,2)
% [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% end
% F1_Score_Class=F1_Score_Class+f1_Score_Class;
% F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% TMBC=TMBC+tmbc;
% TMBC_Class=TMBC_Class+tmbc_Class;
% ConfMatrix=ConfMatrix+ConfMat;
% end
% 
% TMBC=TMBC/Iter_nbre;
% F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% TMBC_Class=TMBC_Class/Iter_nbre;
% F1_Score_Class=F1_Score_Class/Iter_nbre;
% ConfMatrix=ConfMatrix/Iter_nbre;
% 
% tab=zeros(1,3);
% moy=0;
% moy1=0;
% moy2=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
%  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
%  tab(1,1)=moyenne;
%  moy=moy+moyenne;
% [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% tab(1,2)=moyenne1;
% moy1=moy1+moyenne1;
% [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% tab(1,3)=moyenne2;
% moy2=moy2+moyenne2;
% 
% end
% Moy_SANS_=moy/N;
% Moy_F1_Score_Class_=moy1/N;
% Moy_TMBC_Class_=moy2/N;
% tab_total_box(2,1)=Moy_F1_Score_Class_;
% tab_total_box(2,2)=Moy_TMBC_Class_;
% tab_total_box(2,3)=Moy_SANS_;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = wine;
% 
% disp('wine');
% 
% 
% F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% F1_Score_Totat=zeros(1,getsize(a,2));
% f1_Score_Totat=zeros(1,getsize(a,2));
% tmbc=zeros(1,getsize(a,2));
% TMBC=zeros(1,getsize(a,2));
% TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% 
% for o=1:Iter_nbre
%     
% for i=1:getsize(a,2)
% [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% end
% F1_Score_Class=F1_Score_Class+f1_Score_Class;
% F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% TMBC=TMBC+tmbc;
% TMBC_Class=TMBC_Class+tmbc_Class;
% ConfMatrix=ConfMatrix+ConfMat;
% end
% 
% TMBC=TMBC/Iter_nbre;
% F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% TMBC_Class=TMBC_Class/Iter_nbre;
% F1_Score_Class=F1_Score_Class/Iter_nbre;
% ConfMatrix=ConfMatrix/Iter_nbre;
% 
% tab=zeros(1,3);
% moy=0;
% moy1=0;
% moy2=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
%  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
%  tab(1,1)=moyenne;
%  moy=moy+moyenne;
% [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% tab(1,2)=moyenne1;
% moy1=moy1+moyenne1;
% [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% tab(1,3)=moyenne2;
% moy2=moy2+moyenne2;
% 
% end
% Moy_SANS_=moy/N;
% Moy_F1_Score_Class_=moy1/N;
% Moy_TMBC_Class_=moy2/N;
% tab_total_box(3,1)=Moy_F1_Score_Class_;
% tab_total_box(3,2)=Moy_TMBC_Class_;
% tab_total_box(3,3)=Moy_SANS_;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a=load_prdataset('australian.dat',15,15,1,14);
% 
% disp('australian');
% 
% 
% F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% F1_Score_Totat=zeros(1,getsize(a,2));
% f1_Score_Totat=zeros(1,getsize(a,2));
% tmbc=zeros(1,getsize(a,2));
% TMBC=zeros(1,getsize(a,2));
% TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% 
% for o=1:Iter_nbre
%     
% for i=1:getsize(a,2)
% [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% end
% F1_Score_Class=F1_Score_Class+f1_Score_Class;
% F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% TMBC=TMBC+tmbc;
% TMBC_Class=TMBC_Class+tmbc_Class;
% ConfMatrix=ConfMatrix+ConfMat;
% end
% 
% TMBC=TMBC/Iter_nbre;
% F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% TMBC_Class=TMBC_Class/Iter_nbre;
% F1_Score_Class=F1_Score_Class/Iter_nbre;
% ConfMatrix=ConfMatrix/Iter_nbre;
% 
% tab=zeros(1,3);
% moy=0;
% moy1=0;
% moy2=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
%  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
%  tab(1,1)=moyenne;
%  moy=moy+moyenne;
% [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% tab(1,2)=moyenne1;
% moy1=moy1+moyenne1;
% [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% tab(1,3)=moyenne2;
% moy2=moy2+moyenne2;
% 
% end
% Moy_SANS_=moy/N;
% Moy_F1_Score_Class_=moy1/N;
% Moy_TMBC_Class_=moy2/N;
% tab_total_box(4,1)=Moy_F1_Score_Class_;
% tab_total_box(4,2)=Moy_TMBC_Class_;
% tab_total_box(4,3)=Moy_SANS_;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = hepatitis;
% 
% disp('hepatitis');
% 
% 
% F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% F1_Score_Totat=zeros(1,getsize(a,2));
% f1_Score_Totat=zeros(1,getsize(a,2));
% tmbc=zeros(1,getsize(a,2));
% TMBC=zeros(1,getsize(a,2));
% TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% 
% for o=1:Iter_nbre
%     
% for i=1:getsize(a,2)
% [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% end
% F1_Score_Class=F1_Score_Class+f1_Score_Class;
% F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% TMBC=TMBC+tmbc;
% TMBC_Class=TMBC_Class+tmbc_Class;
% ConfMatrix=ConfMatrix+ConfMat;
% end
% 
% TMBC=TMBC/Iter_nbre;
% F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% TMBC_Class=TMBC_Class/Iter_nbre;
% F1_Score_Class=F1_Score_Class/Iter_nbre;
% ConfMatrix=ConfMatrix/Iter_nbre;
% 
% tab=zeros(1,3);
% moy=0;
% moy1=0;
% moy2=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
%  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
%  tab(1,1)=moyenne;
%  moy=moy+moyenne;
% [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% tab(1,2)=moyenne1;
% moy1=moy1+moyenne1;
% [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% tab(1,3)=moyenne2;
% moy2=moy2+moyenne2;
% 
% end
% Moy_SANS_=moy/N;
% Moy_F1_Score_Class_=moy1/N;
% Moy_TMBC_Class_=moy2/N;
% tab_total_box(5,1)=Moy_F1_Score_Class_;
% tab_total_box(5,2)=Moy_TMBC_Class_;
% tab_total_box(5,3)=Moy_SANS_;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = sonar;
% 
% disp('sonar');
% 
% 
% F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% F1_Score_Totat=zeros(1,getsize(a,2));
% f1_Score_Totat=zeros(1,getsize(a,2));
% tmbc=zeros(1,getsize(a,2));
% TMBC=zeros(1,getsize(a,2));
% TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% 
% for o=1:Iter_nbre
%     
% for i=1:getsize(a,2)
% [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% end
% F1_Score_Class=F1_Score_Class+f1_Score_Class;
% F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% TMBC=TMBC+tmbc;
% TMBC_Class=TMBC_Class+tmbc_Class;
% ConfMatrix=ConfMatrix+ConfMat;
% end
% 
% TMBC=TMBC/Iter_nbre;
% F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% TMBC_Class=TMBC_Class/Iter_nbre;
% F1_Score_Class=F1_Score_Class/Iter_nbre;
% ConfMatrix=ConfMatrix/Iter_nbre;
% 
% tab=zeros(1,3);
% moy=0;
% moy1=0;
% moy2=0;
% for i=1:N
%     
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
%  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
%  tab(1,1)=moyenne;
%  moy=moy+moyenne;
% [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% tab(1,2)=moyenne1;
% moy1=moy1+moyenne1;
% [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% tab(1,3)=moyenne2;
% moy2=moy2+moyenne2;
% 
% end
% Moy_SANS_=moy/N;
% Moy_F1_Score_Class_=moy1/N;
% Moy_TMBC_Class_=moy2/N;
% tab_total_box(6,1)=Moy_F1_Score_Class_;
% tab_total_box(6,2)=Moy_TMBC_Class_;
% tab_total_box(6,3)=Moy_SANS_;
% 
% 
% tab_total_box
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % 
% % tab_total_triangle = zeros(6,3);
% % kernel=@Triweight  
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = iris;
% % 
% % disp('iris');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_triangle(1,1)=Moy_F1_Score_Class_;
% % tab_total_triangle(1,2)=Moy_TMBC_Class_;
% % tab_total_triangle(1,3)=Moy_SANS_;
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = heart;
% % 
% % disp('heart');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_triangle(2,1)=Moy_F1_Score_Class_;
% % tab_total_triangle(2,2)=Moy_TMBC_Class_;
% % tab_total_triangle(2,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = wine;
% % 
% % disp('wine');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_triangle(3,1)=Moy_F1_Score_Class_;
% % tab_total_triangle(3,2)=Moy_TMBC_Class_;
% % tab_total_triangle(3,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a=load_prdataset('australian.dat',15,15,1,14);
% % 
% % disp('australian');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_triangle(4,1)=Moy_F1_Score_Class_;
% % tab_total_triangle(4,2)=Moy_TMBC_Class_;
% % tab_total_triangle(4,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = hepatitis;
% % 
% % disp('hepatitis');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_triangle(5,1)=Moy_F1_Score_Class_;
% % tab_total_triangle(5,2)=Moy_TMBC_Class_;
% % tab_total_triangle(5,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = sonar;
% % 
% % disp('sonar');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_triangle(6,1)=Moy_F1_Score_Class_;
% % tab_total_triangle(6,2)=Moy_TMBC_Class_;
% % tab_total_triangle(6,3)=Moy_SANS_;
% % 
% % 
% % tab_total_triangle
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % 
% % tab_total_epanechnikov = zeros(6,3);
% % kernel=@Tricube
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = iris;
% % 
% % disp('iris');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_epanechnikov(1,1)=Moy_F1_Score_Class_;
% % tab_total_epanechnikov(1,2)=Moy_TMBC_Class_;
% % tab_total_epanechnikov(1,3)=Moy_SANS_;
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = heart;
% % 
% % disp('heart');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_epanechnikov(2,1)=Moy_F1_Score_Class_;
% % tab_total_epanechnikov(2,2)=Moy_TMBC_Class_;
% % tab_total_epanechnikov(2,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = wine;
% % 
% % disp('wine');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_epanechnikov(3,1)=Moy_F1_Score_Class_;
% % tab_total_epanechnikov(3,2)=Moy_TMBC_Class_;
% % tab_total_epanechnikov(3,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a=load_prdataset('australian.dat',15,15,1,14);
% % 
% % disp('australian');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_epanechnikov(4,1)=Moy_F1_Score_Class_;
% % tab_total_epanechnikov(4,2)=Moy_TMBC_Class_;
% % tab_total_epanechnikov(4,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = hepatitis;
% % 
% % disp('hepatitis');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_epanechnikov(5,1)=Moy_F1_Score_Class_;
% % tab_total_epanechnikov(5,2)=Moy_TMBC_Class_;
% % tab_total_epanechnikov(5,3)=Moy_SANS_;
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % a = sonar;
% % 
% % disp('sonar');
% % 
% % 
% % F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % F1_Score_Totat=zeros(1,getsize(a,2));
% % f1_Score_Totat=zeros(1,getsize(a,2));
% % tmbc=zeros(1,getsize(a,2));
% % TMBC=zeros(1,getsize(a,2));
% % TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
% % ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
% % 
% % for o=1:Iter_nbre
% %     
% % for i=1:getsize(a,2)
% % [ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
% % [ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
% % ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
% % end
% % F1_Score_Class=F1_Score_Class+f1_Score_Class;
% % F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
% % TMBC=TMBC+tmbc;
% % TMBC_Class=TMBC_Class+tmbc_Class;
% % ConfMatrix=ConfMatrix+ConfMat;
% % end
% % 
% % TMBC=TMBC/Iter_nbre;
% % F1_Score_Totat=F1_Score_Totat/Iter_nbre;
% % TMBC_Class=TMBC_Class/Iter_nbre;
% % F1_Score_Class=F1_Score_Class/Iter_nbre;
% % ConfMatrix=ConfMatrix/Iter_nbre;
% % 
% % tab=zeros(1,3);
% % moy=0;
% % moy1=0;
% % moy2=0;
% % for i=1:N
% %     
% % [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% %  [ moyenne ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel );
% %  tab(1,1)=moyenne;
% %  moy=moy+moyenne;
% % [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,2)=moyenne1;
% % moy1=moy1+moyenne1;
% % [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,TMBC_Class,F1_Score_Totat,ConfMatrix );
% % tab(1,3)=moyenne2;
% % moy2=moy2+moyenne2;
% % 
% % end
% % Moy_SANS_=moy/N;
% % Moy_F1_Score_Class_=moy1/N;
% % Moy_TMBC_Class_=moy2/N;
% % tab_total_epanechnikov(6,1)=Moy_F1_Score_Class_;
% % tab_total_epanechnikov(6,2)=Moy_TMBC_Class_;
% % tab_total_epanechnikov(6,3)=Moy_SANS_;
% % 
% % 
% % tab_total_epanechnikov
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
