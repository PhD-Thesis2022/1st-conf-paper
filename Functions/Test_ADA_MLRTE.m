function [ moy ] = Test_ADA_MLRTE( a,app,test,Attribute_Coeff,F1_Score_Class,F1_Score_Totat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

appData = app.data;
testData = test.data;
Nbre_Classiefieur=sum(Attribute_Coeff(:,1)~=0);
massTab_Ada=zeros(power(2,getsize(a,3))-1,Nbre_Classiefieur);
f = zeros(getsize(test,1) , getsize(a,2) , getsize(a,3));

for i = 1 : getsize(a,2)
    for j = 1 : getsize(a,3)
        f(:,i,j) = ksdensity(appData(getnlab(app)==j,i),testData(:,i));
    end
end

%normalisation

for i = 1 : getsize(test,1)
    for j = 1 : getsize(a,2)
        f(i,j,:) = f(i,j,:)/max(f(i,j,:));
    end
end

Y_Test = zeros(getsize(test,1),1);

for i = 1 : getsize(test,1)
    
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
        
        
        %Affaiblissement
        if nargin > 4
            F1_Score_Totat=F1_Score_Totat-min(F1_Score_Totat)*ones(size(F1_Score_Totat)); % renforcement
           
            masseTab=masseTab.*F1_Score_Class;
            
            for b=1:getsize(a,2)
                v=(1-F1_Score_Class(:,b)).*masseTab(:,b);
                masseTab((power(2,getsize(a,3))-1),b)=masseTab((power(2,getsize(a,3))-1),b)+sum(v);
                %renforcement
                for r=1:power(2,getsize(a,3))-2 
                     masseTab(r,b)= masseTab(r,b) + F1_Score_Totat(b)*masseTab((power(2,getsize(a,3))-1),b)*masseTab(r,b)/(1-masseTab((power(2,getsize(a,3))-1),b));
                end
                masseTab((power(2,getsize(a,3))-1),b)= (1-F1_Score_Totat(b)) *masseTab((power(2,getsize(a,3))-1),b);
                %renforcement
            end
        end
        
        
        
        for g=1:Nbre_Classiefieur
            massTab_Ada(:,g) = Attribute_Coeff(g,2)*masseTab(:,Attribute_Coeff(g,1));
        end
        [~,Y_Test(i)] = max(pignistique(fusion(massTab_Ada)));
        
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
                masseTab(indiceMax(j),j) = valeurMax(j) - valeurMin(j);
            end
        end
        for g=1:Nbre_Classiefieur
            massTab_Ada(:,g) = Attribute_Coeff(g,2)*masseTab(:,Attribute_Coeff(g,1));
        end
        
        [~,Y_Test(i)] = max(pignistique2(fusion2(massTab_Ada)));
    end
    
end
moy =  sum(Y_Test == getnlab(test))/getsize(test,1);

end

