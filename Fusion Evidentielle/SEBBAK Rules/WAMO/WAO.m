function [Masse]=WA0(MasseIn)


[n,m]=size(MasseIn);
masse_Distribution = repmat(0,1,n);


[conjunctive_masses Conflict] = Conjunction_and_Conflict(MasseIn);


Sum_Masses =  sum(MasseIn');
Mean_Sum_Masses = Sum_Masses ./m;

for i=2:n
    masse_Distribution(i) = conjunctive_masses(i)+ Mean_Sum_Masses(i)* Conflict;
end
Masse=masse_Distribution;