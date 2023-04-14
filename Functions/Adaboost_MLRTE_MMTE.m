clear
clc
%a=load_prdataset('australian.dat',15,15,1,14);

N=50;


MMTE_results=zeros(1,9);
MLRTE_results=zeros(1,9);

a=diabetes;
moyenne=0;



F1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
f1_Score_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
F1_Score_Totat=zeros(1,getsize(a,2));
f1_Score_Totat=zeros(1,getsize(a,2));
tmbc=zeros(1,getsize(a,2));
TMBC=zeros(1,getsize(a,2));
TMBC_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
tmbc_Class=zeros((power(2,getsize(a,3))-1),getsize(a,2));
Iter_nbre=10;
for o=1:Iter_nbre
    %o
for i=1:getsize(a,2)
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a(:,i));
[ ~ ,ConfM ] = MMTE_func_Affaib( a(:,i),d1,d2,d3,d4,d5 , 1 );
[ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );

end
F1_Score_Class=F1_Score_Class+f1_Score_Class;
F1_Score_Totat=F1_Score_Totat+f1_Score_Totat;
TMBC=TMBC+tmbc;
TMBC_Class=TMBC_Class+tmbc_Class;
end

TMBC=TMBC/Iter_nbre;
F1_Score_Totat=F1_Score_Totat/Iter_nbre;
TMBC_Class=TMBC_Class/Iter_nbre;
F1_Score_Class=F1_Score_Class/Iter_nbre;
%F1_Score_Class=TMBC_Class./repmat(TMBC,2^getsize(a,3)-1,1)


for k=1:N

moy=0;
[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);

for m = 1 : 5
    
    if ( m == 1 )
        test = d1;
        app = [d2;d3;d4;d5];
    else if ( m == 2 )
            test = d2;
            app = [d1;d3;d4;d5];
        else if ( m == 3 )
                test = d3;
                app = [d1;d2;d4;d5];
            else if ( m == 4 )
                    test = d4;
                    app = [d1;d2;d3;d5];
                else
                    test = d5;
                    app = [d1;d2;d3;d4];
                end
            end
        end
    end
    
    appData = app.data;
    testData = test.data;
    T=getsize(app,2);% le nbre de classifieurs a utiliser
    D=ones(getsize(app,1),1)*1/getsize(app,1);
    Class_Error=zeros(getsize(app,1),getsize(app,2));
    Err=zeros(1,getsize(app,2));%ligne
    Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
    
    for t=1:T
        
        for i=1:getsize(app,2)
            Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
            Err(i)=sum(D.*Class_Error(:,i));
        end
        
        [ValeurMin,indiceMin]=min(Err);
        if(ValeurMin>0.5)
            %disp('Erreur Min > 0.5');
            break
        end
        Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
        tmp=Class_Error(:,indiceMin)*2-1;
        tmp=tmp*Alpha;
        tmp=exp(tmp);
        D=D.*tmp;
        D=D/sum(D);
        Attribute_Coeff(t,1)=indiceMin;
        Attribute_Coeff(t,2)=Alpha;
    end
    moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff, F1_Score_Class,TMBC );
    
end
moy/5
moyenne=moyenne+moy/5;
end

MMTE_results(1)=moyenne/N


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=sonar;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(2)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=heart;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(3)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=wine;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(4)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=iris;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(5)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=breast;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(6)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=biomed;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(7)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=diabetes;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(8)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=liver;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MMTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MMTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MMTE_results(9)=moyenne/N
% 
% 
% 
% a=hepatitis;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(1)=moyenne/N
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=sonar;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(2)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=heart;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(3)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=wine;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(4)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=iris;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(5)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=breast;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(6)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=biomed;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(7)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=diabetes;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(8)=moyenne/N
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a=liver;
% moyenne=0;
% for k=1:N
% 
% moy=0;
% [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
% 
% for m = 1 : 5
%     
%     if ( m == 1 )
%         test = d1;
%         app = [d2;d3;d4;d5];
%     else if ( m == 2 )
%             test = d2;
%             app = [d1;d3;d4;d5];
%         else if ( m == 3 )
%                 test = d3;
%                 app = [d1;d2;d4;d5];
%             else if ( m == 4 )
%                     test = d4;
%                     app = [d1;d2;d3;d5];
%                 else
%                     test = d5;
%                     app = [d1;d2;d3;d4];
%                 end
%             end
%         end
%     end
%     
%     appData = app.data;
%     testData = test.data;
%     T=getsize(app,2);% le nbre de classifieurs a utiliser
%     D=ones(getsize(app,1),1)*1/getsize(app,1);
%     Class_Error=zeros(getsize(app,1),getsize(app,2));
%     Err=zeros(1,getsize(app,2));%ligne
%     Attribute_Coeff=zeros(T,2);%1er colonne : classifieur  2eme colonne : les coeff associes
%     
%     for t=1:T
%         
%         for i=1:getsize(app,2)
%             Class_Error(:,i)= Erreur_ADA_MLRTE(app(:,i));
%             Err(i)=sum(D.*Class_Error(:,i));
%         end
%         
%         [ValeurMin,indiceMin]=min(Err);
%         if(ValeurMin>0.5)
%             %disp('Erreur Min > 0.5');
%             break
%         end
%         Alpha=0.5*log((1-ValeurMin)/ValeurMin)+log10(getsize(app,3)-1);
%         tmp=Class_Error(:,indiceMin)*2-1;
%         tmp=tmp*Alpha;
%         tmp=exp(tmp);
%         D=D.*tmp;
%         D=D/sum(D);
%         Attribute_Coeff(t,1)=indiceMin;
%         Attribute_Coeff(t,2)=Alpha;
%     end
%     moy=moy  + Test_ADA_MLRTE(a,app,test,Attribute_Coeff );
%     
% end
% 
% moyenne=moyenne+moy/5;
% end
% 
% MLRTE_results(9)=moyenne/N
% 
% MMTE_results
% MLRTE_results