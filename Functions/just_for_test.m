clear
%clc
prwaitbar off
prwarning off
%prmemory(500000000)

% %app = load_prdataset('KDDTrain+.dat',42,42,1,41);
% app = load_prdataset('KDDTrain+_20Percent.dat',42,42,1,41);
% appData = app.data;
% 
% %test= load_prdataset('KDDTest+.dat',42,42,1,41);
% test= load_prdataset('KDDTest-21.dat',42,42,1,41);
% testData = test.data;

%memory





kernel='Triweight'
%%%%%%%%%%%%%%%%%%%%%%%%% BeGiN PR-DS  %%%%%%%%%%%%%%%%%%%%%%%%%%%
'KDDTrain+_20Percent KDDTest-21'
%app = load_prdataset('KDDTrain+.dat',42,42,1,41);
app = load_prdataset('KDDTrain+_20Percent.dat',42,42,1,41);
%app=iris;
appData = app.data;

%test= load_prdataset('KDDTest+.dat',42,42,1,41);
test= load_prdataset('KDDTest-21.dat',42,42,1,41);
%test=iris;
testData = test.data;


fusion = 1;
decision = 4;
iterAffaib = 1;
poid = 0
N=1;
valManquantes = 0;
kernel = 'Triweight';
%'begining of the 1st for loop'

a=app;
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


for i=1:getsize(app,2)
    %[ ConfM ] = UAPRC_single( app(:,i) , kernel , valManquantes , iterAffaib );
    [ ConfM ] = UAPRC_singleModified_DeleteIt( app(:,i),test(:,i) , kernel , valManquantes , iterAffaib );
[ f1_Score_Class(:,i),f1_Score_Totat(i),tmbc(i),tmbc_Class(:,i) ] = transf_Confus_Coeff( ConfM );
ConfMat(:,:,i)=ConfMat(:,:,i)+ConfM;
end
F1_Score_Class=f1_Score_Class;
F1_Score_Totat=f1_Score_Totat;
TMBC=tmbc;
TMBC_Class=tmbc_Class;
ConfMatrix=ConfMat;


%'end of the 1st for loop'

moyenne_iris = zeros(size(fusion));

%'begining of the 2nd for loop'
for n=1:N

    moy = zeros(size(fusion));

    [ Y_Test ] = UAPRC( app , test , kernel , fusion , decision , iterAffaib , poid , valManquantes , F1_Score_Class);

    Y_reel = repmat(getnlab(test),1,size(fusion,2));
    moy = moy+sum(Y_Test == Y_reel,1)/getsize(test,1);

    moyenne_iris = moyenne_iris + moy;
end
resultat=moyenne_iris/N*100

%%%%%%%%%%%%%%%%%%%%%%%% FiN  PR-DS  %%%%%%%%%%%%%%%%%%%%%%%%%%%








% %%%%%%%%%%%% Begin State-of-the-art %%%%%%%%%%%%%%%%%
% N=1;
% NA=getsize(app,2);
% NC=getsize(app,3);
% 
% Eqdc = 0;
% Eldc = 0;
% Enaivebc=0;
% %Esvm = 0;
% %Eknn = 0;
% Enmc = 0;
% %Etree = 0;
% 
% for p=1:N
% 
%     eqdc = 0;
%     eldc = 0;
%     enaivebc=0;
%    % esvm = 0;
%     %eknn = 0;
%     enmc = 0;
%     %etree = 0;
% 
%     %tester les classifieurs de la littérature
% 
%     eqdc = eqdc + testc(test,qdc(app));
%     eldc = eldc + testc(test,ldc(app));
%     enaivebc=enaivebc + testc(test,naivebc(app));
%     %esvm = esvm + testc(test,svc(app));
%     %eknn = eknn + testc(test,knnc(app));
%     enmc = enmc + testc(test,nmc(app));
%     %etree = etree +testc(test,treec(app));
% 
% 
%     Eqdc = Eqdc + eqdc;
%     Eldc = Eldc + eldc;
%     Enaivebc=Enaivebc+enaivebc;
%     %Esvm = Esvm + esvm;
%     %Eknn = Eknn + eknn;
%     Enmc = Enmc + enmc;
%     %Etree = Etree +etree;
% 
% end
% 
% Mqdc = (1 - Eqdc/N)*100
% Mldc = (1 - Eldc/N)*100
% Mnaivebc = (1-Enaivebc/N)*100
% %Msvm = (1 - Esvm/N)*100
% %Mknn = (1 - Eknn/N)*100
% Mnmc = (1 - Enmc/N)*100
% %Mtree = (1 - Etree/N)*100
% 
% %%%%%%%%%%%%%%%%%%%%%% FiN State-of-the-art %%%%%%%%%%%%%%%%%%%%%%%%%







% %%%%%%%%%%%%%%%%%%%%%%%%%%% BEGIN MLRTE %%%%%%%%%%%%%%%%%%%%%
% 
% N = 10;
% 
% moyenne=0;
% a=app;
% 
% for n= 1: N
%     
%     moy = 0;
%     
%     %tester les classifieurs de la littérature
%     
%     
%     %getsize(dataset,1) returne le nombre d'objets
%     %getsize(dataset,2) returne le nombre d'attributs
%     %getsize(dataset,3) returne le nombre de classes
%     
%     %f est utilisée pour sauvgarder les projections sur les fonctions densités
%     %de probabilité estimées à partir des données d'apprentissages
%     %f( objets , attributs , classes )
%     f = zeros(getsize(test,1) , getsize(a,2) , getsize(a,3));
%     
%     for i = 1 : getsize(a,2)
%         for j = 1 : getsize(a,3)
%             f(:,i,j) = ksdensity(appData(getnlab(app)==j,i),testData(:,i));%,'kernel','normal');
%             % 'normal'       'box'     'triangle'   'epanechnikov'
%             % @biwi     @cosine     @cubique   @epa
%             %  @parze    @Triw    @Triweight
%         end
%     end
%     
%     %normalisation
%     
%     for i = 1 : getsize(test,1)
%         for j = 1 : getsize(a,2)
%             if(max(f(i,j,:)) ~= 0 )
%                 f(i,j,:) = f(i,j,:)/max(f(i,j,:));
%             end
%         end
%     end
%     
%     Y_Test = zeros(getsize(test,1),1);
%     
%     for i = 1 : getsize(test,1)
%         
%         %création du tableau des masses
%         masseTab = zeros(2^getsize(a,3)-1,getsize(a,2));
%         
%         %     hypothèse/attribut    | Sl | SW | Pl | PW |
%         %-------------------------------------------------
%         %   {classe 1 = "setosa"}   |    |    |    |    |
%         % {classe 2 = "versicolor"} |    |    |    |    |
%         %  {classe 3 = "verginica"} |    |    |    |    |
%         %        {1,2}              |    |    |    |    |
%         %        {1,3}              |    |    |    |    |
%         %        {2,3}              |    |    |    |    |
%         %       {1,2,3}             |    |    |    |    |
%         
%         %getsize(a,2) return le nombre d'attributs
%         valeurMin = zeros(getsize(a,2),1);
%         indiceMin = zeros(getsize(a,2),1);
%         valeurMax = zeros(getsize(a,2),1);
%         indiceMax = zeros(getsize(a,2),1);
%         indiceMed = zeros(getsize(a,2),1);
%         
%         if( getsize(a,3) == 3) %on a 3 classes
%             for j = 1 : getsize(a,2)
%                 %récuperer la valeur min et max et leur indice(la classe) pour
%                 %chaque attribut
%                 [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
%                 [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
%                 if(valeurMax(j)==0)
%                     masseTab(7,j) = 1;
%                 else
%                     %affecter la valeur min à la 7 éme ligne de la table des masses
%                     %(relative à la masse de l'ensemble{1,2,3})
%                     masseTab(7,j) = valeurMin(j);
%                     
%                     %calculer l'indice de la valeur médiane
%                     indiceMed(j) = 6 - indiceMin(j) - indiceMax(j);
%                     
%                     %chaque hypothèse complexe de cardinale 2 se trouve sur la ligne
%                     %"indiceMed+indiceMax+1 = 7-indiceMin"
%                     masseTab(7-indiceMin(j),j) = f(i,j,indiceMed(j)) - valeurMin(j);
%                     
%                     %affecter la valeur max à sa classe (l'indiceMax)
%                     masseTab(indiceMax(j),j) = valeurMax(j) - f(i,j,indiceMed(j));
%                 end
%             end
%             [maxT,Y_Test(i)] = max(pignistique(fusion(masseTab)));
%         else
%             if ( getsize(a,3) == 2) %on a 2 classes
%                 for j = 1 : getsize(a,2)
%                     %récuperer la valeur min et max et leur indice(la classe) pour
%                     %chaque attribut
%                     [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
%                     [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
%                     if(valeurMax(j)==0)
%                         masseTab(3,j) = 1;
%                     else
%                         %affecter la valeur min à la 3 éme ligne de la table des masses
%                         %(relative à la masse de l'ensemble{1,2})
%                         masseTab(3,j) = valeurMin(j);
%                         
%                         %affecter la valeur max à sa classe (l'indiceMax)
%                         masseTab(indiceMax(j),j) = valeurMax(j) - valeurMin(j);
%                     end
%                 end
%             end
%             [maxT,Y_Test(i)] = max(pignistique2(fusion2(masseTab)));
%         end
%         
%     end
%     moy = moy + sum(Y_Test == getnlab(test))/getsize(test,1);
%     n
%     moyX=moy
%     moyenne = moyenne + moy;
%     
% end
% moyenne = (moyenne/N)*100
% %%%%%%%%%%%%%%%%%%%%%%%%%%% FIN MLRTE %%%%%%%%%%%%%%%%%%%%%