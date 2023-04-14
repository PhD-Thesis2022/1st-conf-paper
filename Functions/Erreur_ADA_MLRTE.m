function [ Class_Error ] = Erreur_ADA_MLRTE( a )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Data = a.data;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = zeros(getsize(a,1), getsize(a,3));

for j = 1 : getsize(a,3)
    f(:,j) = ksdensity(Data(getnlab(a)==j,1),Data(:,1));
end

Y_Test = zeros(getsize(a,1),1);
for i = 1 : getsize(a,1)
    [~,Y_Test(i)] = max(f(i,:));
end

Class_Error= Y_Test ~= getnlab(a);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end





