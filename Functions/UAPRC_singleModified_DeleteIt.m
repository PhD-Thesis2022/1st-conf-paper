function [ ConfM ] = UAPRC_singleModified_DeleteIt( app, test , kernel , valManquantes ,iterAffaib )

if (valManquantes)
    app = prmissingvalues(app,'remove');
end

NC=getsize(app,3);
ConfM = zeros(NC,NC);

for n = 1:iterAffaib

    
    confM_tmp=zeros(NC,NC);
 
        
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
    
    
    ConfM = ConfM + confM_tmp;
end
ConfM = ConfM/iterAffaib;
end

