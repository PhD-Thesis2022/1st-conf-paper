clear 
clc

resultat = zeros(6,2,21);

fusion = 1:21;
decision = 4;
iterAffaib = 10;
poid = 1;
N=100;

num1 = 1;
kernel = 'Triangle'
%%%%%%%%%%%%%%%%%%%%
num2 = 1;
a = iris;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_iris = zeros(size(fusion));
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
    moyenne_iris = moyenne_iris + moy/5;
end
resultat(num2,num1,:)=moyenne_iris/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = heart;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_heart = zeros(size(fusion));
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
    moyenne_heart = moyenne_heart + moy/5;
end
resultat(num2,num1,:)=moyenne_heart/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = wine;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_wine = zeros(size(fusion));
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
    moyenne_wine = moyenne_wine + moy/5;
end
resultat(num2,num1,:)=moyenne_wine/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = load_prdataset('australian.dat',15,15,1,14);
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_australian = zeros(size(fusion));
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
        [ Y_Test ] = UAPRC( app , test , kernel , fusion , decision , iterAffaib , poid , valManquantes  , F1_Score_Class);
        Y_reel = repmat(getnlab(test),1,size(fusion,2));
        moy = moy+sum(Y_Test == Y_reel,1)/getsize(test,1);
    end
    moyenne_australian = moyenne_australian + moy/5;
end
resultat(num2,num1,:)=moyenne_australian/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = load_prdataset('hepatitis.dat',20,1,2,20);
valManquantes = 1;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_hepatitis = zeros(size(fusion));
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
    moyenne_hepatitis = moyenne_hepatitis + moy/5;
end
resultat(num2,num1,:)=moyenne_hepatitis/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = sonar;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_sonar = zeros(size(fusion));
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
    moyenne_sonar = moyenne_sonar + moy/5;
end
resultat(num2,num1,:)=moyenne_sonar/N*100;

resultat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


num1 = 2;
kernel = 'Normal'
%%%%%%%%%%%%%%%%%%%%
num2 = 1;
a = iris;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_iris = zeros(size(fusion));
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
    moyenne_iris = moyenne_iris + moy/5;
end
resultat(num2,num1,:)=moyenne_iris/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = heart;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_heart = zeros(size(fusion));
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
    moyenne_heart = moyenne_heart + moy/5;
end
resultat(num2,num1,:)=moyenne_heart/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = wine;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_wine = zeros(size(fusion));
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
    moyenne_wine = moyenne_wine + moy/5;
end
resultat(num2,num1,:)=moyenne_wine/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = load_prdataset('australian.dat',15,15,1,14);
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_australian = zeros(size(fusion));
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
        [ Y_Test ] = UAPRC( app , test , kernel , fusion , decision , iterAffaib , poid , valManquantes  , F1_Score_Class);
        Y_reel = repmat(getnlab(test),1,size(fusion,2));
        moy = moy+sum(Y_Test == Y_reel,1)/getsize(test,1);
    end
    moyenne_australian = moyenne_australian + moy/5;
end
resultat(num2,num1,:)=moyenne_australian/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = load_prdataset('hepatitis.dat',20,1,2,20);
valManquantes = 1;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_hepatitis = zeros(size(fusion));
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
    moyenne_hepatitis = moyenne_hepatitis + moy/5;
end
resultat(num2,num1,:)=moyenne_hepatitis/N*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2 = num2+1;
a = sonar;
valManquantes = 0;

F1_Score_Class = zeros(2^getsize(a,3),getsize(a,2));
for i=1:getsize(a,2)
    [ ConfM ] = UAPRC_single( a(:,i) , kernel , valManquantes , iterAffaib );
    x = transf_Confus_Coeff( ConfM );
    F1_Score_Class(:,i) = [0;x];
end

moyenne_sonar = zeros(size(fusion));
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
    moyenne_sonar = moyenne_sonar + moy/5;
end
resultat(num2,num1,:)=moyenne_sonar/N*100;

resultat