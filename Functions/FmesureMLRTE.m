function [ VEC , VAL ] = FmesureMLRTE( dataset,d1,d2,d3,d4,d5 , N )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


VEC = zeros(1,getsize(dataset,2));

[ ~ ,confM ] = MLRTE_func_Affaib( dataset,d1,d2,d3,d4,d5 , N );
[ ~ , VAL ] = Fmesure( confM );

for i=1:getsize(dataset,2)
    a = dataset(:,i);
    a1=d1(:,i);
    a2=d2(:,i);
    a3=d3(:,i);
    a4=d4(:,i);
    a5=d5(:,i);
    
    [ ~ ,confM ] = MLRTE_func_Affaib( a,a1,a2,a3,a4,a5,N );
    
    [ ~ , VEC(i) ] = Fmesure( confM );    
end

