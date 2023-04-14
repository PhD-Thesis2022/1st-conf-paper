function [Masse]= get_Weighted_Conjunctive(MasseIn)

[n,m]=size(MasseIn);

% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));


 for j=1 :m
     for i=2:n
         MasseIn(i,j)= MasseIn(i,j)/ get_Cardinality(i);
     end
 end
 
 b=repmat(1,1,n);
 q=repmat(1,1,n);
 for i=1:m
    bj=mtob(MasseIn(:,i));
    qj=mtoq(MasseIn(:,i));
   
    b=b.*bj;
    q=q.*qj;
 end

 in=q;
 
lm = length(in);
natoms = round(log2(lm)); 		

if 2^natoms == lm 
for step = 1:natoms 
	i124 = 2^(step-1);		
	i842 = 2^(natoms+1-step);	
	i421 = 2^(natoms - step) ;	
	in = reshape(in,i124,i842);

    in(:,(1:i421)*2-1) = in(:,(1:i421)*2-1) - in(:,(1:i421)*2);
end

out = reshape(in,1,lm);

for step = 1:lm 
    out(step)=out(step)*get_Cardinality(step)^m;
end

else
	'ACCIDENT in qtom: length of input vector not OK: should be a power of 2'
end

 
 
 Masse = out;

