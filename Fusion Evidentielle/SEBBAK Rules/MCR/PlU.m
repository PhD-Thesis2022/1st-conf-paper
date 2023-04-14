function [Masse]=PlU(MasseIn)

 [n,m]=size(MasseIn);
 Final_Masses = repmat(0,1,n);
 
 
  for i=2:n
      for j=1:m
          for k=2:n
              element = get_Intersect_Focal(i,k);
              if(element ~=1 )
                  Final_Masses(i) = Final_Masses(i) + MasseIn(k,j);
              end
          end
      end
  end
  Final_Masses =Final_Masses ./ m;
 
  Masse=Final_Masses;
 
 