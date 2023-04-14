function [ MAT , kVEC , kVAL , fVEC , fVAL ] = weakeningMat( A , U )
%weakeningMat computes the weakening coeficients using a standard 
%classifier.
%
% INPUT
% A         N*K prdataset, with N items, K attributs and C classes
%
% OUTPUT
% MAT       C*K weakening coefficient matrix computed by f-mesure
% kVEC      1*K weakening coefficient vector computed by Kappa
% kVAL      Kappa coefficient
% fVEC      1*K weakening coefficient vector computed by f-mesure
% fVAL      Fmesure coefficient

%A = hepatitis;
%U = naivebc;

C = getsize(A,3);
K = getsize(A,2);

W = A*U; 
D = A*W;            %The same datesat is used for training and test
c = confmat(D);     
kVAL = Kappa(c);
[ ~ , fVAL ] = Fmesure( c );

MAT = zeros(C,K);
kVEC = zeros(1,K);
fVEC = zeros(1,K);

for i = 1 : K
    a = A(:,i);
    W = a*U;
    D = a*W;
    c = confmat(D);
    [ vec , valeur ] = Fmesure( c );
    MAT(:,i) = vec;
    fVEC(i) = valeur;
    kVEC(i) = Kappa(c);
    if ( kVEC(i) <= 0 ) 
        kVEC(i) = 0;
    end
end
end

