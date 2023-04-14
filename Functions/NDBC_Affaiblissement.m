clear;
clc;
a = iris;
N = 20;

moyenne=0;

%les coefficients d'affaiblissement de chaque classe pour chaque source
%(attribut)

[MAT,VEC,VAL] = weakeningMat( a );

aff_Coeff = MAT;
aff_Coeff=ones(getsize(a,3),getsize(a,2));

coeff = VEC./VAL
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
            
            
            
            if( getsize(a,3) == 3) %on a 3 classes
                
                valeurMin = zeros(getsize(a,2),1);
                indiceMin = zeros(getsize(a,2),1);
                valeurMax = zeros(getsize(a,2),1);
                indiceMax = zeros(getsize(a,2),1);
                valeurMed = zeros(getsize(a,2),1);
                indiceMed = zeros(getsize(a,2),1);
                
                for j = 1 : getsize(a,2)
                    %récuperer la valeur min et max et leur indice(la classe) pour
                    %chaque attribut
                    [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
                    [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
                    
                    %calculer l'indice de la valeur médiane
                    indiceMed(j) = 6 - indiceMin(j) - indiceMax(j);
                    valeurMed(j) = f(i,j,indiceMed(j));
                    
                    
                    
                    %création du tableau des masses de chaque classe
                    
                    ClassMasseTab = zeros(2^getsize(a,3)-1,getsize(a,3));
                    
                    %     hypothèse/attribut    | C1 | C2 | C3 |
                    %-------------------------------------------
                    %   {classe 1 = "setosa"}   |    |    |    |
                    % {classe 2 = "versicolor"} |    |    |    |
                    %  {classe 3 = "verginica"} |    |    |    |
                    %        {1,2}              |    |    |    |
                    %        {1,3}              |    |    |    |
                    %        {2,3}              |    |    |    |
                    %       {1,2,3}             |    |    |    |
                    
                    
                    %pour le max
                    
                    ClassMasseTab(indiceMax(j),indiceMax(j))= aff_Coeff(indiceMax(j),j)*valeurMax(j);
                    ClassMasseTab( 7 - indiceMax(j),indiceMax(j))= aff_Coeff(indiceMax(j),j)*(1-valeurMax(j));
                    ClassMasseTab( 7 ,indiceMax(j))= 1 - aff_Coeff(indiceMax(j),j);
                    
                    
                    %pour le min
                    
                    ClassMasseTab(indiceMin(j),indiceMin(j))= aff_Coeff(indiceMin(j),j)*valeurMin(j);
                    ClassMasseTab( 7 - indiceMin(j),indiceMin(j))= aff_Coeff(indiceMin(j),j)*(1-valeurMin(j));
                    ClassMasseTab( 7 ,indiceMin(j))= 1 - aff_Coeff(indiceMin(j),j);
                    
                    
                    %pour le med
                    
                    ClassMasseTab(indiceMed(j),indiceMed(j))= aff_Coeff(indiceMed(j),j)*valeurMed(j);
                    ClassMasseTab( 7 - indiceMed(j),indiceMed(j))= aff_Coeff(indiceMed(j),j)*(1-valeurMed(j));
                    ClassMasseTab( 7 ,indiceMed(j))= 1 - aff_Coeff(indiceMed(j),j);
                    
                    
                    
                    
                    %======================================================
                    % la fonction de fusion entre les 3 classes seulement
                    % et non pas entre les attribues
                    %======================================================
                    
                    m_tmp = ClassMasseTab(:,1);
                    M = zeros(7,1);
                    for p = 2 : size(ClassMasseTab,2)
                        M(1) = m_tmp(1)*(ClassMasseTab(1,p)+ClassMasseTab(4,p)+ClassMasseTab(5,p)+ClassMasseTab(7,p)) + ClassMasseTab(1,p)*(m_tmp(4)+m_tmp(5)+m_tmp(7)) + m_tmp(4)*ClassMasseTab(5,p) + ClassMasseTab(4,p)*m_tmp(5);
                        M(2) = m_tmp(2)*(ClassMasseTab(2,p)+ClassMasseTab(4,p)+ClassMasseTab(6,p)+ClassMasseTab(7,p)) + ClassMasseTab(2,p)*(m_tmp(4)+m_tmp(6)+m_tmp(7)) + m_tmp(4)*ClassMasseTab(6,p) + ClassMasseTab(4,p)*m_tmp(6);
                        M(3) = m_tmp(3)*(ClassMasseTab(3,p)+ClassMasseTab(5,p)+ClassMasseTab(6,p)+ClassMasseTab(7,p)) + ClassMasseTab(3,p)*(m_tmp(5)+m_tmp(6)+m_tmp(7)) + m_tmp(5)*ClassMasseTab(6,p) + ClassMasseTab(5,p)*m_tmp(6);
                        M(4) = m_tmp(4)*(ClassMasseTab(4,p)+ClassMasseTab(7,p)) + ClassMasseTab(4,p)*m_tmp(7);
                        M(5) = m_tmp(5)*(ClassMasseTab(5,p)+ClassMasseTab(7,p)) + ClassMasseTab(5,p)*m_tmp(7);
                        M(6) = m_tmp(6)*(ClassMasseTab(6,p)+ClassMasseTab(7,p)) + ClassMasseTab(6,p)*m_tmp(7);
                        M(7) = m_tmp(7)*ClassMasseTab(7,p);
                        M = M/sum(M);
                        m_tmp = M;
                    end
                    
                    %=====================================================
                    %end
                    %=====================================================
                    
                    
                    
                    
                    %affecter les valeurs des masses de la jeme attribue
                    masseTab(:,j)=M;
                    
                    
                end
                masseTab = weaken(masseTab,coeff);
                
                [maxT,Y_Test(i)] = max(pignistique(fusion(masseTab)));
                
            else if ( getsize(a,3) == 2) %on a 2 classes
                    
                    for j = 1 : getsize(a,2)
                        
                        %récuperer la valeur min et max et leur indice(la classe) pour
                        %chaque attribut
                        [valeurMin(j),indiceMin(j)] = min(f(i,j,:));
                        [valeurMax(j),indiceMax(j)] = max(f(i,j,:));
                        
                        
                        %création du tableau des masses de chaque classe
                        
                        ClassMasseTab = zeros(2^getsize(a,3)-1,getsize(a,3));
                        
                        %     hypothèse/attribut    | C1 | C2 |
                        %--------------------------------------
                        %   {classe 1 = "setosa"}   |    |    |
                        % {classe 2 = "versicolor"} |    |    |
                        %        {1,2}              |    |    |
                        
                        
                        %pour le max
                        
                        ClassMasseTab(indiceMax(j),indiceMax(j))= aff_Coeff(indiceMax(j),j)*valeurMax(j);
                        ClassMasseTab( 3 - indiceMax(j),indiceMax(j))= aff_Coeff(indiceMax(j),j)*(1-valeurMax(j));
                        ClassMasseTab( 3 ,indiceMax(j))= 1 - aff_Coeff(indiceMax(j),j);
                        
                        %pour le min
                        
                        ClassMasseTab(indiceMin(j),indiceMin(j))= aff_Coeff(indiceMin(j),j)*valeurMin(j);
                        ClassMasseTab( 3 - indiceMin(j),indiceMin(j))= aff_Coeff(indiceMin(j),j)*(1-valeurMin(j));
                        ClassMasseTab( 3 ,indiceMin(j))= 1 - aff_Coeff(indiceMin(j),j);
                        
                        
                        
                        %======================================================
                        % la fonction de fusion entre les 3 classes seulement
                        % et non pas entre les attribues
                        %======================================================
                        
                        
                        
                        m_tmp = ClassMasseTab(:,1);
                        M = zeros(3,1);
                        for p = 2 : size(ClassMasseTab,2)
                            M(1) = m_tmp(1)*(ClassMasseTab(1,p)+ClassMasseTab(3,p)) + ClassMasseTab(1,p)*m_tmp(3);
                            M(2) = m_tmp(2)*(ClassMasseTab(2,p)+ClassMasseTab(3,p)) + ClassMasseTab(2,p)*m_tmp(3);
                            M(3) = m_tmp(3)*ClassMasseTab(3,p)  ;
                            M = M/sum(M);
                            m_tmp = M;
                        end
                        
                        
                        %=====================================================
                        %end
                        %=====================================================
                        
                        
                        
                    %affecter les valeurs des masses de la jeme attribue
                    masseTab(:,j)=M;
                    
                        
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
