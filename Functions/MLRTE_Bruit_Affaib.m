clear
clc
%b = iris;
b=load_prdataset('virusf.dat',267,267,1,266);
N=20;
Iter_nbre=10;
NA=getsize(b,2);
NC=getsize(b,3);
tab=zeros(3,10,NA);

%estimation des coefficients
F1_Score_Class=zeros((power(2,NC)-1),NA);
f1_Score_Class=zeros((power(2,NC)-1),NA);
tmbc=zeros(1,NA);
TMBC=zeros(1,NA);
for o=1:Iter_nbre
    %o
    for i=1:NA
        [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(b(:,i));
        [ ConfM ] = MLRTE_Single_Attribute( b(:,i) );
        [ f1_Score_Class(:,i),~,tmbc(i),~ ] = transf_Confus_Coeff( ConfM );
    end
    F1_Score_Class=F1_Score_Class+f1_Score_Class;
    TMBC=TMBC+tmbc;
end
TMBC=TMBC/Iter_nbre;
F1_Score_Class=F1_Score_Class/Iter_nbre;

TMBC_orig=TMBC;
F1_Score_Class_orig=F1_Score_Class;

%bruitage des attributes

for i=1:NA
    a=b;
    for j=1:10
        
        Data=a.data;
        for c=1:NC
            %correction: each value should be randomized
            Nbre_elem_per_class=sum(getnlab(a)==c);
            bruit=zeros(Nbre_elem_per_class,1);
            for l=1:Nbre_elem_per_class
                ecart=std(Data(:,i));
                bruit(l)=2*j*ecart*randn-j*ecart;
            end
            Data(getnlab(a)==c,i)=Data(getnlab(a)==c,i)+ bruit;
        end

        a.data=Data;
        
        %estimation des coefficients
        TMBC=TMBC_orig;
        TMBC(i)=0;
        F1_Score_Class=F1_Score_Class_orig;
        F1_Score_Class(:,i)=zeros((power(2,NC)-1),1);
        for o=1:Iter_nbre
            [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a(:,i));
            [ ConfM ] = MLRTE_Single_Attribute( a(:,i) );
            [ f1_Score_Class(:,i),~,tmbc(i),~ ] = transf_Confus_Coeff( ConfM );
            F1_Score_Class(:,i)=F1_Score_Class(:,i)+f1_Score_Class(:,i);
            TMBC(i)=TMBC(i)+tmbc(i);
        end
        TMBC(i)=TMBC(i)/Iter_nbre;
        F1_Score_Class(:,i)=F1_Score_Class(:,i)/Iter_nbre;
        
        moy1=0;
        moy2=0;
        for p=1:N
            
            [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
            [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,F1_Score_Class,TMBC );
            
            [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1);
            moy1=moy1+moyenne1;
            moy2=moy2+moyenne2;
        end
        tab(1,j,i)=moy1/N
        tab(2,j,i)=moy2/N
        tab(3,j,i)=TMBC(i)
        
    end
    
    
end



