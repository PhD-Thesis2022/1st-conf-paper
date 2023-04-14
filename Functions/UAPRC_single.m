function [ ConfM ] = UAPRC_single( a , kernel , valManquantes ,iterAffaib )

if (valManquantes)
    a = prmissingvalues(a,'remove');
end

NC=getsize(a,3);
ConfM = zeros(NC,NC);

for n = 1:iterAffaib

    [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
    confM_tmp=zeros(NC,NC);
    for m = 1 : 5
        % app -> données d'apprentissage
        % test -> données de test
        if ( m == 1 )
            test = d1;
            app = [d2;d3;d4;d5];
        else
            if ( m == 2 )
                test = d2;
                app = [d1;d3;d4;d5];
            else
                if ( m == 3 )
                    test = d3;
                    app = [d1;d2;d4;d5];
                else
                    if ( m == 4 )
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
        NO=getsize(test,1);
        
        f = zeros(NO, NC);
        
        for j = 1 : NC
            f(:,j) = ksdensity(appData(getnlab(app)==j),testData,'kernel',kernel);
        end
        
        Y_Test = zeros(NO,1);
        for i = 1 : NO
            [~,Y_Test(i)] = max(f(i,:));
        end
        
        confM_tmp=confM_tmp+confmat_perso(getnlab(test),Y_Test,NC);
    end
    
    ConfM = ConfM + confM_tmp/5;
end
ConfM = ConfM/iterAffaib;
end

