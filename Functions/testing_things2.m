mmm=4 ;
plot(tab_iris(1,:,mmm),'r :');
 hold on
  plot(tab_iris(2,:,mmm),'b :');
 hold on
 
  plot(100*tab_iris(3,:,mmm),'g :');
 hold off
 





% clear
% clc
% PRWARNING(0)
% PRWAITBAR OFF
% 
% disp('iris')
%  a=iris;
%  N=5;
% Iter_nbre=10;
% NO=getsize(a,1);
% NA=getsize(a,2);
% NC=getsize(a,3);
% 
% %ajout d'aatribut poubelle
%  poubelle=10*rand(NO,1);
% Data=zeros(NO,NA+1);
% Data(:,1:NA)=a.data;
% Data(:,NA+1)=poubelle;
%  a = prdataset(Data,getnlab(a));
% 
% NA=NA+1;
% 
% 
% tab_iris=zeros(10,1);
% 
% %estimation des coefficients
% F1_Score_Class=zeros((power(2,NC)-1),NA);
% f1_Score_Class=zeros((power(2,NC)-1),NA);
% tmbc=zeros(1,NA);
% TMBC=zeros(1,NA);
% for o=1:Iter_nbre
%     %o
%     for i=1:NA
%         [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a(:,i));
%         [ ConfM ] = MLRTE_Single_Attribute( a(:,i) );
%         [ f1_Score_Class(:,i),~,tmbc(i),~ ] = transf_Confus_Coeff( ConfM );
%     end
%     F1_Score_Class=F1_Score_Class+f1_Score_Class;
%     
%     TMBC=TMBC+tmbc;
% end
% TMBC=TMBC/Iter_nbre;
% F1_Score_Class=F1_Score_Class/Iter_nbre;
% 
% TMBC_orig=TMBC;
% F1_Score_Class_orig=F1_Score_Class;
% 
% %bruitage des attributes
% 
% 
%         moy1=0;
%         moy2=0;
%         Eqdc = 0;
%         Eldc = 0;
%         Esvm = 0;
%         Eknn = 0;
%         Enmc = 0;
%         Enaivebc = 0;
%         Etree = 0;
%         
%         for p=1:N
%             p
%             [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
%             [ moyenne1 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1,F1_Score_Class,TMBC);
%             
%             [ moyenne2 ,~ ] = MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,1);
%             moy1=moy1+moyenne1;
%             moy2=moy2+moyenne2;
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             
%             
%             eqdc = 0;
%             eldc = 0;
%             esvm = 0;
%             eknn = 0;
%             enmc = 0;
%             enaivebc = 0;
%             etree = 0;
%             for m = 1 : 5
%                 % app -> données d'apprentissage
%                 % test -> données de test
%                 if ( m == 1 )
%                     test = d1;
%                     app = [d2;d3;d4;d5];
%                 else if ( m == 2 )
%                         test = d2;
%                         app = [d1;d3;d4;d5];
%                     else if ( m == 3 )
%                             test = d3;
%                             app = [d1;d2;d4;d5];
%                         else if ( m == 4 )
%                                 test = d4;
%                                 app = [d1;d2;d3;d5];
%                             else
%                                 test = d5;
%                                 app = [d1;d2;d3;d4];
%                             end
%                         end
%                     end
%                 end
%                 
%                 appData = app.data;
%                 testData = test.data;
%                 
%                 %tester les classifieurs de la littérature
%                 
%                 eqdc = eqdc + testc(test,qdc(app));
%                 eldc = eldc + testc(test,ldc(app));
%                 esvm = esvm + testc(test,svc(app));
%                 eknn = eknn + testc(test,knnc(app));
%                 enmc = enmc + testc(test,nmc(app));
%                 enaivebc = enaivebc + testc(test,naivebc(app));
%                 etree = etree +testc(test,treec(app));
%             end
%             
%             Eqdc = Eqdc + eqdc/5;
%             Eldc = Eldc + eldc/5;
%             Esvm = Esvm + esvm/5;
%             Eknn = Eknn + eknn/5;
%             Enmc = Enmc + enmc/5;
%             Enaivebc = Enaivebc + enaivebc/5;
%             Etree = Etree +etree/5;
%             
%             
%             
%             
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             
%         end
%         
%         tab_iris(1)=moy1/N;
%         tab_iris(2)=moy2/N;
%         tab_iris(3)=TMBC(i);
%         tab_iris(4) = (1 - Eqdc/N)*100;
%         tab_iris(5) = (1 - Eldc/N)*100;
%         tab_iris(6) = (1 - Esvm/N)*100;
%         tab_iris(7) = (1 - Eknn/N)*100;
%         tab_iris(8) = (1 - Enmc/N)*100;
%         tab_iris(9) = (1 - Enaivebc/N)*100;
%         tab_iris(10) = (1 - Etree/N)*100
%         
