function [Masse]=get_Consensus_Matrix(MasseIn, tab_inter)

[n,m]=size(MasseIn);
% Calcul de la taille du cadre de discernement
taille_discernement=(log2(n));


masses=MasseIn;
    
    

Res_final =[];

for j=2:n
    if(masses(j,1)~=0)
         indice_conjunction_mul = size (tab_inter );
         indice_conjunction_mul= indice_conjunction_mul(2)+1;
    
         tab_inter(:,indice_conjunction_mul) = j;
         mul = masses(j,1);
         
        if(m~=1)
            MM = MasseIn(:,2:m);
            Res_final = [Res_final ; get_Consensus_Matrix(MM, tab_inter)];

            indice_conjunction_mul = indice_conjunction_mul-1;
                 if (indice_conjunction_mul > 0) 
                         tab_inter =  tab_inter(:,1:indice_conjunction_mul);
                  else
                     tab_inter=[];
                  end
        else

            subs = substituer(tab_inter,taille_discernement);
            if(subs ~= 1)
%                 tab_inter
                Res_final = [Res_final ; tab_inter] ;
            end
            indice_conjunction_mul = indice_conjunction_mul-1;
            if (indice_conjunction_mul > 0) 
                tab_inter =  tab_inter(:,1:indice_conjunction_mul);
            else
                tab_inter=[];
            end
        end
         
    end
 end
         Masse =  Res_final ;

  return
