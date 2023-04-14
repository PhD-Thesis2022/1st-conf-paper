function [ kappa ] = Kappa( confMat )
% Kappa computes the Kappa coeficient of the confusion matrix confMat.
%
% INPUT
% confMat   C*C confusion matrix issued from the classification of a sample
%           containing C classes
%
% OUTPUT
% kappa       Kappa coeficient

N = sum(sum(confMat));
X = 0;
Y = 0;
for i = 1 : size(confMat,1)
    X = X + confMat(i,i);
    Y = Y + sum(confMat(i,:))*sum(confMat(:,i));
end
OA = X/N; % Observed Accuracy 
EA = Y/N.^2; % Expected Accuracy
kappa = (OA - EA)/(1 - EA);
end