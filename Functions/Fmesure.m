function [ VEC , VAL ] = Fmesure( confMat )
% Fmesure computes the Kappa coeficient of the confusion matrix confMat.
%
% INPUT
% confMat   C*C confusion matrix issued from the classification of a sample
%           containing C classes
%
% OUTPUT
% VEC       C*1 vector containing the fmesure of each class (assuming
%           binary classification)
% VAL       The fmesure for all the confusion matrix

% A = iris;
% U = naivebc;
% a = A(:,2);
% W = a*U;
% D = a*W;
% confMat = confmat(D);

C = size(confMat,1);
VEC = zeros(C,1);
precision = zeros(C,1);
recall = zeros(C,1);
X = sum(confMat,1);   %sum of the columns
Y = sum(confMat,2);   %sum of the lines

for j = 1 : C
    TP = confMat(j,j);    %TP: Truth Positive
    if (TP == 0) 
        VEC(j) = 0;
    else
    FP = X(j)-TP;         %FP: False Positive
    FN = Y(j)-TP;         %FN: False Negative
    precision(j) = TP/(TP+FP);
    recall(j) = TP/(TP+FN);
    VEC(j) = 2*(precision(j)*recall(j)/(precision(j)+recall(j)));
    end
end
Mpre = mean(precision);
Mrec = mean(recall);
VAL = 2*(Mpre*Mrec/(Mpre+Mrec));
end

