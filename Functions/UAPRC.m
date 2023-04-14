function [ Y_Test ] = UAPRC( app , test , kernel , fusion , decision , iterAffaib , poid , valManquantes , F1_Score_Class)

% app = wine;%load_prdataset('hepatitis.dat',20,1,1,20);
% test = app(1,:);
% kernel = 'box';
% fusion = 2;
% decision = 4;%[1 3 4];
% iterAffaib = 1;
% poid = 1;
% valManquantes = 1;

NO = getsize(test,1);
NA = getsize(app,2);
NC = getsize(app,3);

if (poid)
    ponderation = 1:NC;
else
    ponderation = ones(1,NC);
end

if (nargin < 9)
    F1_Score_Class = ones(2^NC,NA);
    if (iterAffaib > 0)
        for i=1:NA
            [ ConfM ] = UAPRC_single( app(:,i) , kernel , valManquantes , iterAffaib );
            x = transf_Confus_Coeff( ConfM );
            F1_Score_Class(:,i) = [0;x];
        end
    end
end

appData = app.data;
testData = test.data;

f = zeros(NO , NA , NC);

if (valManquantes)
    for i = 1 : NO
        for j = 1 : NA
            if ( isnan(testData(i,j)) )
                f(i,j,1) = NaN;
            else
                for k = 1 : NC
                    f(i,j,k) = ksdensity(appData(getnlab(app)==k,j),testData(i,j),'kernel',kernel);
                    % 'normal'       'box'     'triangle'   'epanechnikov'
                    % @biwi     @cosine     @cubique   @epa
                    %  @parze    @Triw    @Triweight
                end
            end
        end
    end
else
    for i = 1 : NA
        for j = 1 : NC
            f(:,i,j) = ksdensity(appData(getnlab(app)==j,i),testData(:,i),'kernel',kernel);
            % 'normal'       'box'     'triangle'   'epanechnikov'
            % @biwi     @cosine     @cubique   @epa
            %  @parze    @Triw    @Triweight
        end
    end
end

%Y_Test = zeros(size(decision,2),NO,size(fusion,2));
Y_Test = zeros(NO,size(fusion,2));

for i = 1 : NO
    masseTab = zeros(2^NC,NA);
    densityTab = zeros(1,NC);
    for j = 1 : NA
        if ( isnan(f(i,j,1)) || (sum(f(i,j,:)) == 0) )
            masseTab(2^NC,j)=1;
        else
            for k = 1 : NC
                densityTab(k) = f(i,j,k);
            end
            [Y,I] = sort(densityTab,2,'descend');
            
            for k = 1 : NC-1
                Y(k) = Y(k) - Y(k+1); %la difference entre les masses des hypothèses
            end
            massePondere = Y.*ponderation;
            massePondereNorm = massePondere/sum(massePondere);%normalisation
            
            %affectation des masses pondérée à la table des masses
            indice = 1;
            for k = 1 : NC
                indice = indice+2^(I(k)-1);
                masseTab(indice,j) = massePondereNorm(k);
            end
            masseTab_old=masseTab;
            masseTab(:,j)=masseTab_old(:,j).*F1_Score_Class(:,j);
            v=(1-F1_Score_Class(:,j)).*masseTab_old(:,j);
            masseTab(2^NC,j)=masseTab(2^NC,j)+sum(v);
        end
    end
    
    Masse = zeros(2^NC,size(fusion,2));
    
    
    for q = 1:size(fusion,2)
        if ( fusion(q)  <= 12  && fusion(q)~=8 && fusion(q)~=11 )
            Masse(:,q) = DST(masseTab,fusion(q))';
        else
            switch q
                case 13
                    Masse(:,q) = WAMO(masseTab,1)';
                case 14
                    Masse(:,q) = WAMO(masseTab,2)';
                case 15
                    Masse(:,q) = WAMO(masseTab,3)';
                case 16
                    Masse(:,q) = CRC(masseTab)';
                case 17
                    Masse(:,q) = CREC(masseTab)';
  %               case 18
 %                    Masse(:,q) = PCCR(masseTab)';
                case 19
                    Masse(:,q) = TCR1(masseTab)';
                case 20
                    Masse(:,q) = TCR2(masseTab)';
                case 21
                    Masse(:,q) = MCR(masseTab)';
            end
        end
%         for d = 1:size(decision,2)
%             Y_Test(d,i,q) = decisionDST(Masse(:,q),decision(d));
%         end
        Y_Test(i,q) = decisionDST(Masse(:,q),decision);
    end      

end
end

