clear;
clc;
a = sonar;
%load_prdataset('australian.dat',15,15,1,14)
N = 10;



moyenne=0;


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
        
        % les probabilites a prio
        
        prio=ones(2^getsize(a,3)-1,1);
        
        
        if( getsize(a,3) == 3)
            cs=[sum(getnlab(app)==1),sum(getnlab(app)==2),sum(getnlab(app)==3)];
            pri=[cs,cs(1)+cs(2),cs(1)+cs(3),cs(2)+cs(3),cs(1)+cs(2)+cs(3)];
        else if ( getsize(a,3) == 2)
                cs=[sum(getnlab(app)==1),sum(getnlab(app)==2)];
                pri=[cs,cs(1)+cs(2)];
            end
        end
         %       prio=pri/sum(pri)
        
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
                    
                    f(:,i,1) = ksdensity(appData(getnlab(app)==1,i),testData(:,i),'kernel','SigmoidFunction');
                    
                    f(:,i,2) = ksdensity(appData(getnlab(app)==2,i),testData(:,i),'kernel','SigmoidFunction');
                    
                    f(:,i,3) = (cs(1)/sum(cs))*ksdensity(appData(getnlab(app)==1,i),testData(:,i))+(cs(2)/sum(cs))*ksdensity(appData(getnlab(app)==2,i),testData(:,i),'kernel','SigmoidFunction');
                    
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
            
            %masseTab = weaken(masseTab,coeff);
            if( getsize(a,3) == 3) %on a 3 classes
                
                [maxT,Y_Test(i)] = max(pignistique(fusion(masseTab)));
                
                %[maxT,Y_Test(i)] = max((cs/sum(cs))'.*pignistique(fusion(masseTab)));
            else if ( getsize(a,3) == 2) %on a 2 classes
                    [maxT,Y_Test(i)] = max(pignistique2(fusion2(masseTab)));
                    
                    %[maxT,Y_Test(i)] = max((cs/sum(cs))'.*pignistique2(fusion2(masseTab)));
                    
                end
            end
        end
        moy = moy + sum(Y_Test == getnlab(test))/getsize(test,1);
        
    end
    mx = (moy/5)*100
    moyenne = moyenne + moy/5;

end

moyenne = (moyenne/N)*100
