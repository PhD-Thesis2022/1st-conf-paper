function [ moyenne ,confM ] = MMTE_func_Affaib( a,d1,d2,d3,d4,d5,N,F1_Score_Class,F1_Score_Totat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin <= 7
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
        
        % les probabilites a prio
        
        
        
        
        if( getsize(a,3) == 3)
            cs=[sum(getnlab(app)==1),sum(getnlab(app)==2),sum(getnlab(app)==3)];
            
        else if ( getsize(a,3) == 2)
                cs=[sum(getnlab(app)==1),sum(getnlab(app)==2)];
                
            end
        end
        
        
        %tester les classifieurs de la littérature
        
        
        %getsize(dataset,1) returne le nombre d'objets
        %getsize(dataset,2) returne le nombre d'attributs
        %getsize(dataset,3) returne le nombre de classes
        
        %f est utilisée pour sauvgarder les projections sur les fonctions densités
        %de probabilité estimées à partir des données d'apprentissages
        %f( objets , attributs , classes )
        
        % f is the massTab after the normalisation <<< important <<<
        f = zeros(getsize(test,1) , getsize(a,2) , 2^getsize(a,3)-1);
        
        if( getsize(a,3) == 3) %on a 3 classes
            
            
            for i = 1 : getsize(a,2)
                
                f(:,i,1) = ksdensity(appData(getnlab(app)==1,i),testData(:,i));
                
                f(:,i,2) = ksdensity(appData(getnlab(app)==2,i),testData(:,i));
                
                f(:,i,3) = ksdensity(appData(getnlab(app)==3,i),testData(:,i));
                
                f(:,i,4) = (cs(1)/(cs(1)+cs(2)))*ksdensity(appData(getnlab(app)==1,i),testData(:,i))+(cs(2)/(cs(1)+cs(2)))*ksdensity(appData(getnlab(app)==2,i),testData(:,i));
                
                f(:,i,5) = (cs(1)/(cs(1)+cs(3)))*ksdensity(appData(getnlab(app)==1,i),testData(:,i))+(cs(3)/(cs(1)+cs(3)))*ksdensity(appData(getnlab(app)==3,i),testData(:,i));
                
                f(:,i,6) = (cs(2)/(cs(2)+cs(3)))*ksdensity(appData(getnlab(app)==2,i),testData(:,i))+(cs(3)/(cs(2)+cs(3)))*ksdensity(appData(getnlab(app)==3,i),testData(:,i));
                
                f(:,i,7) =(cs(1)/sum(cs))*ksdensity(appData(getnlab(app)==1,i),testData(:,i))+(cs(2)/sum(cs))*ksdensity(appData(getnlab(app)==2,i),testData(:,i))+(cs(3)/sum(cs))*ksdensity(appData(getnlab(app)==3,i),testData(:,i));
                
            end
            
        else if ( getsize(a,3) == 2) %on a 2 classes
                
                for i = 1 : getsize(a,2)
                    
                    f(:,i,1) = ksdensity(appData(getnlab(app)==1,i),testData(:,i));
                    
                    f(:,i,2) = ksdensity(appData(getnlab(app)==2,i),testData(:,i));
                    
                    f(:,i,3) = (cs(1)/sum(cs))*ksdensity(appData(getnlab(app)==1,i),testData(:,i))+(cs(2)/sum(cs))*ksdensity(appData(getnlab(app)==2,i),testData(:,i));
                    
                end
                
            end
            
        end
        
        
        % la normalisation
        S=sum(f,3);
        for i=1:2^getsize(a,3)-1
            f(:,:,i)=f(:,:,i)./S;
        end
        
        Y_Test = zeros(getsize(test,1),1);
        
        for i = 1 : getsize(test,1)
            masseTab= reshape(f(i,:,:),getsize(a,2),2^getsize(a,3)-1)';
            
            % masseTab = weaken(masseTab,F1_Score_Class);
            %masseTab_old=masseTab
            
            
            
            %Affaiblissement
            if nargin > 7
                %F1_Score_Totat=F1_Score_Totat-min(F1_Score_Totat)*ones(size(F1_Score_Totat));
                masseTab=masseTab.*F1_Score_Class;
                %v=ones((power(2,getsize(a,3))-1),1);
                for b=1:getsize(a,2)
                    v=(1-F1_Score_Class(:,b)).*masseTab(:,b);
                    masseTab((power(2,getsize(a,3))-1),b)=masseTab((power(2,getsize(a,3))-1),b)+sum(v);
                    %for r=1:power(2,getsize(a,3))-2
                    %    masseTab(r,b)= masseTab(r,b) + F1_Score_Totat(b)*masseTab((power(2,getsize(a,3))-1),b)*masseTab(r,b)/(1-masseTab((power(2,getsize(a,3))-1),b));
                    %end
                    %masseTab((power(2,getsize(a,3))-1),b)= (1-F1_Score_Totat(b)) *masseTab((power(2,getsize(a,3))-1),b);
                    
                end
            end
            
            %masseTab_new=masseTab
            
            if( getsize(a,3) == 3) %on a 3 classes
                %fus_old= fusion(masseTab_old)';
                fus_new= fusion(masseTab)';
                [~,Y_Test(i)] = max(pignistique(fus_new));
                
                %[maxT,Y_Test(i)] = max((cs/sum(cs))'.*pignistique(fusion(masseTab)));
            else if ( getsize(a,3) == 2) %on a 2 classes
                    %fus_old= fusion2(masseTab_old)'
                    fus_new= fusion2(masseTab)';
                    
                    [~,Y_Test(i)] = max(pignistique2(fus_new));
                    
                    %[maxT,Y_Test(i)] = max((cs/sum(cs))'.*pignistique2(fusion2(masseTab)));
                    
                end
            end
            %GUESS=Y_Test(i)
            %TRUTH=getnlab(test(i,:))
        end
        
        moy = moy + sum(Y_Test == getnlab(test))/getsize(test,1);
        
        % UNCOMMENT THIS INSTRUCTION AS SOON AS YOU SEE IT
        confM_tmp=confM_tmp+confmat_perso(getnlab(test),Y_Test,getsize(a,3));
    end
    %mx = (moy/5)*100
    moyenne = moyenne + moy/5;
    
    confM = confM+confM_tmp/5;
    
end

moyenne = (moyenne/N)*100;

confM=confM/N;


end

