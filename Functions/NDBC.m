clear;
clc;
a = sonar;
N = 100;

moyenne=0;

[MAT,VEC,VAL] = weakeningMat( a );
coeff = VEC./VAL;
coeff = ones(1,getsize(a,2));

for n= 1: N
    n
    [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
    moy = 0;
    
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
        
        %getsize(dataset,1) returne le nombre d'objets
        %getsize(dataset,2) returne le nombre d'attributs
        %getsize(dataset,3) returne le nombre de classes
        
        %f est utilisée pour sauvgarder les projections sur les fonctions densités
        %de probabilité estimées à partir des données d'apprentissages
        %f( objets , attributs , classes )
        
        %initialisation
        f = zeros(getsize(test,1) , getsize(a,2) , getsize(a,3));
        MUHAT=ones(getsize(a,3),getsize(a,2));
        SIGMAHAT=ones(getsize(a,3),getsize(a,2));
        
        %estimation de moyen et ecart-type
        for i = 1 : getsize(a,3)
            [MUHAT(i,:),SIGMAHAT(i,:)] = normfit(appData(getnlab(app)==i,:));
        end
        
        
        % calcul des valeur de fonction densite de probabilite pour chaque
        % objet de test
        
        for i = 1 : getsize(test,1)
            for k = 1 : getsize(a,3)
                f(i,:,k)= normpdf(testData(i,:),MUHAT(k,:),SIGMAHAT(k,:));
            end
        end
        
        %normalisation
        
        for i = 1 : getsize(test,1)
            for j = 1 : getsize(a,2)
                f(i,j,:) = f(i,j,:)/sum(f(i,j,:));
            end
        end
        
        Y_Test = zeros(getsize(test,1),1);
        
        for i = 1 : getsize(test,1)
            
            %création du tableau des masses
            masseTab = zeros(2^getsize(a,3)-1,getsize(a,2));
            
            %     hypothèse/attribut    | Sl | SW | Pl | PW |
            %-------------------------------------------------
            %   {classe 1 = "setosa"}   |    |    |    |    |
            % {classe 2 = "versicolor"} |    |    |    |    |
            %  {classe 3 = "verginica"} |    |    |    |    |
            %        {1,2}              |    |    |    |    |
            %        {1,3}              |    |    |    |    |
            %        {2,3}              |    |    |    |    |
            %       {1,2,3}             |    |    |    |    |
            
            
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
                    
                    %affecter la valeur min à la 7 éme ligne de la table des masses
                    %(relative à la masse de l'ensemble{1,2,3})
                    masseTab(7,j) = valeurMin(j);
                    
                    %calculer l'indice de la valeur médiane
                    indiceMed(j) = 6 - indiceMin(j) - indiceMax(j);
                    
                    %chaque hypothèse complexe de cardinale 2 se trouve sur la ligne
                    %"indiceMed+indiceMax+1 = 7-indiceMin"
                    masseTab(7-indiceMin(j),j) = f(i,j,indiceMed(j));
                    
                    %affecter la valeur max à sa classe (l'indiceMax)
                    masseTab(indiceMax(j),j) = valeurMax(j);
                end
                masseTab = weaken(masseTab,coeff);
                
                [maxT,Y_Test(i)] = max(pignistique(fusion(masseTab)));
            else if ( getsize(a,3) == 2) %on a 2 classes
                    for j = 1 : getsize(a,2)
                        %récuperer la valeur min et max et leur indice(la classe) pour
                        %chaque attribut
                        [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
                        [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
                        
                        %affecter la valeur min à la 3 éme ligne de la table des masses
                        %(relative à la masse de l'ensemble{1,2})
                        masseTab(3,j) = valeurMin(j);
                        
                        %affecter la valeur max à sa classe (l'indiceMax)
                        masseTab(indiceMax(j),j) = valeurMax(j);
                    end
                    masseTab = weaken(masseTab,coeff);
                    
                    [maxT,Y_Test(i)] = max(pignistique2(fusion2(masseTab)));
                end
                
            end
            
        end
        moy = moy + sum(Y_Test == getnlab(test))/getsize(test,1);
    end
    moyenne = moyenne + moy/5;
    
end
moyenne = (moyenne/N)*100
