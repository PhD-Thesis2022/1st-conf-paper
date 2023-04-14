function [ confM ] = confmat_perso( Y_orig,Y_test,NC )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

confM=zeros(NC,NC);
for i=1:size(Y_orig,1)
confM(Y_orig(i),Y_test(i))=confM(Y_orig(i),Y_test(i))+1;
end

end

