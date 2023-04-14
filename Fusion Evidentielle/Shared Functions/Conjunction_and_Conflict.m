function [Masse, Conflict] = Conjunction_and_Conflict(MasseIn)

[n,m]=size(MasseIn);


 b=repmat(1,1,n);
 q=repmat(1,1,n);
 for i=1:m
    bj=mtob(MasseIn(:,i));
    qj=mtoq(MasseIn(:,i));
   
    b=b.*bj;
    q=q.*qj;
 end


        %Dempster-Shafer criteria (normalized)
        
        Masse = qtom(q);
        Conflict = Masse(1);
        Masse(1)=0;
        
        

      

