clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%
% la nouvelle idée de ponderation

%without
%ponderation=ones(1,3);

%with
ponderation=1:3;
%%%%%%%%%%%%%%%%%%%%%%%%%
%IR=wine;
IR=sonar;%load_prdataset('australian.dat',15,15,1,14);
kernel='normal';

min_impro=1e-5;
expo=2;

% fuzzy C-means
%[~,U,~] = fcm(IR.data,getsize(IR,3));
% [~,LABELS] = max(U);
%FC_D=prdataset(IR,LABELS');

%K-means
% [LABELS,~] = kmeans(IR.data,getsize(IR,3));
% FC_D=prdataset(IR,LABELS);

%hclust
d = sqrt(distm(IR));
LABELS = hclust(d,'complete',getsize(IR,3));
FC_D=prdataset(IR,LABELS);

[ D ] = ClusteringCorrectAffectation( IR,FC_D );
a=D;
LABELS= getnlab(D);

moy_kmeams = sum(LABELS == getnlab(IR))/getsize(IR,1)*100

N = 20;
moyenne=0;

U=zeros(getsize(a,3),getsize(a,1));
obj_fcn = zeros(N, 1);	% Array for objective function
for n= 1: N
    
    
    
    
    
    Data = a.data;
    
    f = zeros(getsize(a,1) , getsize(a,2) , getsize(a,3));
    
    for i = 1 : getsize(a,2)
        for j = 1 : getsize(a,3)
            f(:,i,j) = ksdensity(Data(getnlab(a)==j,i),Data(:,i),'kernel',kernel);
        end
    end
    
    %normalisation
    
    for i = 1 : getsize(a,1)
        for j = 1 : getsize(a,2)
            if(max(f(i,j,:)) ~= 0 )
                f(i,j,:) = f(i,j,:)/max(f(i,j,:));
            end
        end
    end
    
    
    
    Y_Test = zeros(getsize(a,1),1);
    
    for i = 1 : getsize(a,1)
        
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
                    %calculer l'indice de la valeur médiane
                    indiceMed(j) = 6 - indiceMin(j) - indiceMax(j);
                    
                    %affecter la valeur min à la 7 éme ligne de la table des masses
                    %(relative à la masse de l'ensemble{1,2,3})
                    masseTab(7,j) = ponderation(3)*valeurMin(j)/(ponderation(3)*valeurMin(j)+ ponderation(2)*(f(i,j,indiceMed(j)) - valeurMin(j))+valeurMax(j) - f(i,j,indiceMed(j)));
                    
                    %chaque hypothèse complexe de cardinale 2 se trouve sur la ligne
                    %"indiceMed+indiceMax+1 = 7-indiceMin"
                    masseTab(7-indiceMin(j),j) = ponderation(2)*(f(i,j,indiceMed(j)) - valeurMin(j))/(ponderation(3)*valeurMin(j)+ ponderation(2)*(f(i,j,indiceMed(j)) - valeurMin(j))+valeurMax(j) - f(i,j,indiceMed(j)));
                    
                    %affecter la valeur max à sa classe (l'indiceMax)
                    masseTab(indiceMax(j),j) = (valeurMax(j) - f(i,j,indiceMed(j)))/(ponderation(3)*valeurMin(j)+ ponderation(2)*(f(i,j,indiceMed(j)) - valeurMin(j))+valeurMax(j) - f(i,j,indiceMed(j)));
                end
            end
            
            U(:,i) = pignistique(fusion(masseTab));
            [maxT,Y_Test(i)] = max(U(:,i));
            
            
            
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
                        masseTab(3,j) = ponderation(2)*valeurMin(j)/(ponderation(2)*valeurMin(j)+valeurMax(j) - valeurMin(j));
                        
                        %affecter la valeur max à sa classe (l'indiceMax)
                        masseTab(indiceMax(j),j) = (valeurMax(j) - valeurMin(j))/(ponderation(2)*valeurMin(j)+valeurMax(j) - valeurMin(j));
                    end
                end
            end
            
            U(:,i) = pignistique2(fusion2(masseTab));
            [maxT,Y_Test(i)] = max(U(:,i));
            
            
        end
        
    end
    moy_iter=sum(Y_Test == getnlab(IR))/getsize(IR,1)*100
    
    if(moyenne < moy_iter)
        moyenne = moy_iter;
    end
    mf = U.^expo;       % MF matrix after exponential modification
    center = mf*Data./((ones(size(Data, 2), 1)*sum(mf'))'); % new center
    dist = distfcm(center, Data);       % fill the distance matrix
    obj_fcn(n) = sum(sum((dist.^2).*mf));  % objective function
    
    if n > 1,
        if abs(obj_fcn(n) - obj_fcn(n-1)) < min_impro, break; end,
    end
    
    a = SETNLAB(a,Y_Test);
    
    
end
iter_n = n;	% Actual number of iterations
obj_fcn(iter_n+1:N) = [];
MaXi=moyenne