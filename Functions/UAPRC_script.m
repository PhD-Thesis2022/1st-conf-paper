clear 


app = load_prdataset('KDDTrain+_20Percent.dat',42,42,1,41);
test= load_prdataset('KDDTest-21.dat',42,42,1,41);

a = [app;test];


resultat = zeros(1,1,1);

fusion = 2;
decision = 4;
iterAffaib = 10;
poid = 0;
N=10;

num1 = 1;
kernel = 'Triweight'
%%%%%%%%%%%%%%%%%%%%
num2 = 1;

valManquantes = 0;
'First loop'
F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end
F1_Score_Class

'Second loop'
moyenne_ = zeros(size(fusion));
for n=1:N
    [d1,d2,d3,d4,d5] = FiveFoldCrossValidation(a);
    moy = zeros(size(fusion));
    for m = 1 : 5
        m;
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
        [ Y_Test ] = UAPRC( app , test , kernel , fusion , decision , iterAffaib , poid , valManquantes , F1_Score_Class);
        Y_reel = repmat(getnlab(test),1,size(fusion,2));
        moy = moy+sum(Y_Test == Y_reel,1)/getsize(test,1);
    end
    moyenne_ = moyenne_ + moy/5;
end
resultat(num2,num1,:)=moyenne_/N*100

