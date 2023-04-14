function [Masse]=Convert_Masses(MasseIn,n)


Mot = '';
New_Masse= repmat(0,1,2^n);
v= repmat(0,1,1);

z=size(MasseIn);
z= z(2);


while z>0
 
    %Eliminer les espace au debut de la chaine
     find = findstr(' ', MasseIn);
     s_f=size(find);
     while (s_f(2) ~=0 & find(1)==1)
            MasseIn = MasseIn(2:z);
            find = findstr(' ', MasseIn);
            s_f=size(find);
            z=size(MasseIn);
            z= z(2);
     end 
     if( z>0 )
         
        [focal_and_value, reste] = strtok(MasseIn, ' ');
  
   
       
        %Remplir le nom est la valeur de l'element focal
       [focal, valeur] = strtok(focal_and_value, '(');
       valeur=valeur(2:length(valeur)-1);
    
        indice = get_number_from_focal_str(focal);
  
        v=str2num(valeur);
         New_Masse(indice)= v;

        indice2= findstr(reste, MasseIn);
        MasseIn=MasseIn(indice2:length(MasseIn));
        z=size(MasseIn);
        z= z(2);
    end
   
end

Masse = New_Masse'; 
