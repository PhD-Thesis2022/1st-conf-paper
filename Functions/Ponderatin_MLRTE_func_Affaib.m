function [ moyenne ,confM ] = Ponderatin_MLRTE_func_Affaib( a,d1,d2,d3,d4,d5,N,kernel, F1_Score_Class,F1_Score_Totat,confMat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin ==8
    F1_Score_Class=ones(1, getsize(a,2));
end
moyenne=0;

confM=zeros(getsize(a,3),getsize(a,3));


for n= 1: N
    %n
    %[d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
    moy = 0;
    confM_tmp=zeros(getsize(a,3),getsize(a,3));
    for m = 1 : 5
        % app -> données d'apprentissage
        % test -> données de test
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
        

        
        % f is the massTab after the normalisation <<< important <<<
        f = zeros(getsize(test,1) , getsize(a,2) , getsize(a,3));
        %'kernel'     The type of kernel smoother to use, chosen from among
        %            'normal' (default), 'box', 'triangle', and
        %            'epanechnikov'.
        for i = 1 : getsize(a,2)
            for j = 1 : getsize(a,3)
                f(:,i,j) = ksdensity(appData(getnlab(app)==j,i),testData(:,i),'kernel',kernel);
                % 'normal'       'box'     'triangle'   'epanechnikov'
                % @biwi     @cosine     @cubique   @epa 
                %  @parze    @Triw    @Triweight
            end
        end
        
        %normalisation
        
        for i = 1 : getsize(test,1)
            for j = 1 : getsize(a,2)
                if(max(f(i,j,:)) ~= 0 )
                f(i,j,:) = f(i,j,:)/max(f(i,j,:));
                end
            end
        end
        
        Y_Test = zeros(getsize(test,1),1);
        
        for i = 1 : getsize(test,1)
            %i
            %création du tableau des masses
            masseTab = zeros(2^getsize(a,3)-1,getsize(a,2));
            
            %getsize(a,2) return le nombre d'attributs
            valeurMin = zeros(getsize(a,2),1);
            indiceMin = zeros(getsize(a,2),1);
            valeurMax = zeros(getsize(a,2),1);
            indiceMax = zeros(getsize(a,2),1);
            indiceMed = zeros(getsize(a,2),1);
            
            if( getsize(a,3) == 3) %on a 3 classes
                for j = 1 : getsize(a,2)
                    %récuperer la valeur min et max et leur indice(la classe) pour
                    %chaque attribut
                    
                    
                    [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
                    [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
                    if(valeurMax(j)==0)
                        masseTab(7,j) = 1;
                    else
                    %affecter la valeur min à la 7 éme ligne de la table des masses
                    %(relative à la masse de l'ensemble{1,2,3})
                    masseTab(7,j) = valeurMin(j);
                    
                    %calculer l'indice de la valeur médiane
                    indiceMed(j) = 6 - indiceMin(j) - indiceMax(j);
                    
                    %chaque hypothèse complexe de cardinale 2 se trouve sur la ligne
                    %"indiceMed+indiceMax+1 = 7-indiceMin"
                    masseTab(7-indiceMin(j),j) = f(i,j,indiceMed(j)) - valeurMin(j);
                    
                    %affecter la valeur max à sa classe (l'indiceMax)
                    masseTab(indiceMax(j),j) = valeurMax(j) - f(i,j,indiceMed(j));
                    end
                end
                %masseTab = weaken(masseTab,F1_Score_Class);
                %                 F1_Score_Class
                %                 masseTab_before=masseTab
                %Affaiblissement
                if nargin > 8
                    % F1_Score_Totat=F1_Score_Totat-min(F1_Score_Totat)*ones(size(F1_Score_Totat));
                    masseTab=masseTab.*F1_Score_Class;
                    
                    for b=1:getsize(a,2)
                        v=(1-F1_Score_Class(:,b)).*masseTab(:,b);
                        masseTab((power(2,getsize(a,3))-1),b)=masseTab((power(2,getsize(a,3))-1),b)+sum(v);
                        %for r=1:power(2,getsize(a,3))-2
                        %    masseTab(r,b)= masseTab(r,b) + F1_Score_Totat(b)*masseTab((power(2,getsize(a,3))-1),b)*masseTab(r,b)/(1-masseTab((power(2,getsize(a,3))-1),b));
                        %end
                        %masseTab((power(2,getsize(a,3))-1),b)= (1-F1_Score_Totat(b)) *masseTab((power(2,getsize(a,3))-1),b);
                        
                    end
                end
                
                %                 masseTab_After=masseTab
                
                [~,Y_Test(i)] = max(pignistique(fusion(masseTab)));
                %GUESS=Y_Test(i)
                %TRUTH=getnlab(test(i,:))
            else if ( getsize(a,3) == 2) %on a 2 classes
                    for j = 1 : getsize(a,2)
                        %récuperer la valeur min et max et leur indice(la classe) pour
                        %chaque attribut
                        [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
                        [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
                        if(valeurMax(j)==0)
                            masseTab(3,j) = 1;
                        else
                        %affecter la valeur min à la 3 éme ligne de la table des masses
                        %(relative à la masse de l'ensemble{1,2})
                        masseTab(3,j) = valeurMin(j);
                        
                        %affecter la valeur max à sa classe (l'indiceMax)
                        masseTab(indiceMax(j),j) = valeurMax(j) - valeurMin(j);
                        end
                    end
                end
                % masseTab = weaken(masseTab,F1_Score_Class);
                %                 F1_Score_Class
                %                 masseTab_before=masseTab
                
                %Affaiblissement
                if nargin > 8                
                    %F1_Score_Totat=F1_Score_Totat-min(F1_Score_Totat)*ones(size(F1_Score_Totat));
                    masseTab=masseTab.*F1_Score_Class;
                    % v=ones((power(2,getsize(a,3))-1),1);
                    for b=1:getsize(a,2)
                        v=(1-F1_Score_Class(:,b)).*masseTab(:,b);
                        masseTab((power(2,getsize(a,3))-1),b)=masseTab((power(2,getsize(a,3))-1),b)+sum(v);
                        %for r=1:power(2,getsize(a,3))-2
                        %   masseTab(r,b)= masseTab(r,b) + F1_Score_Totat(b)*masseTab((power(2,getsize(a,3))-1),b)*masseTab(r,b)/(1-masseTab((power(2,getsize(a,3))-1),b));
                        %end
                        %masseTab((power(2,getsize(a,3))-1),b)= (1-F1_Score_Totat(b)) *masseTab((power(2,getsize(a,3))-1),b);
                        
                    end
                end
                
                %                 masseTab_after=masseTab
                
                [~,Y_Test(i)] = max(pignistique2(fusion2(masseTab)));
            end
            
        end
        moy = moy + sum(Y_Test == getnlab(test))/getsize(test,1);
        
        
        confM_tmp=confM_tmp+confmat_perso(getnlab(test),Y_Test,getsize(a,3));
    end
    %mx = (moy/5)*100
    moyenne = moyenne + moy/5;
    
    confM = confM+confM_tmp/5;
    
end

moyenne = (moyenne/N)*100;

confM=confM/N;


end

