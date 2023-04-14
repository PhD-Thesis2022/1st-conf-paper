function y = exist_produit_not_null(mass)

[n,m]=size(mass);

val=0;
 for i=1:m
     find=0;
     for j=1:n
         if (mass(j,i) ~= 0)
             find=1;
             val=val+mass(j,i) ;
         end
     end
     if(find==0) 
         y = 0;
         return
     end
 end
 if(find==0) 
     y = 0;
     return
 else
     y = val;
     return
 end
