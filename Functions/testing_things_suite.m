clear;

%a=load_prdataset('australian.dat',15,15,1,14);


N=20;
Iter_nbre=10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tab_total_normal = zeros(6,11);
kernel='epanechnikov' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,1)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,1)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,1)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,1)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,1)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,1)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='box' 
nbre=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='triangle' 
nbre=3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='normal' 
nbre=4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='biweight' 
nbre=5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='cosine' 
nbre=6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='parzen' 
nbre=7;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='Triweight' 
nbre=8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='Tricube' 
nbre=9;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='SigmoidFunction' 
nbre=10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kernel='Logistic' 
nbre=11;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = iris;
disp('iris');

F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(1,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = heart;
disp('heart');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(2,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = wine;
disp('wine');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(3,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=load_prdataset('australian.dat',15,15,1,14);
disp('australian');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(4,nbre)=Moy_F1_Score_Class_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = hepatitis;
disp('hepatitis');
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(5,nbre)=Moy_F1_Score_Class_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = sonar;
disp('sonar')
F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
ConfMatrix=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
ConfMat=zeros(getsize(a,3),getsize(a,3),getsize(a,2));
for o=1:Iter_nbre
for i=1:getsize(a,2)
[ ConfM ] = MLRTE_Single_Attribute( a(:,i),kernel );
[ f1_Score_Class(:,i),~ ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
ConfMatrix=ConfMatrix+ConfMat;
end
F1_Score_Class=F1_Score_Class/Iter_nbre;
ConfMatrix=ConfMatrix/Iter_nbre;
moy1=0;
for i=1:N    
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
[ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,kernel,F1_Score_Class,[],ConfMatrix );
moy1=moy1+moyenne1;
end
Moy_F1_Score_Class_=moy1/N;
tab_total_normal(6,nbre)=Moy_F1_Score_Class_;

tab_total_normal








