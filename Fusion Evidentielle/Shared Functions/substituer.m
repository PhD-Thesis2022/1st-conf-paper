function [focal]= substituer(tab,  taille_discernement)

s= size(tab );
s=s(2) ; 

while (s > 1)
     V_tmp = get_Intersect_Focal(tab(1),tab(2));
     tab=[V_tmp tab(:,3:s)];
     s= size(tab);
     s=s(2);        
end


focal=tab(1);
