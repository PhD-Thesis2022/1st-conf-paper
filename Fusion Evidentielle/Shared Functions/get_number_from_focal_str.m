function [valeur]=get_number_from_focal_str(str_focal)
% clc

% str_focal=['ae']
All_focal=[];


z=size(str_focal);
z= z(2);
i=1;
while z>0
    val1 = str_focal(1);
    str_focal =str_focal(2:length(str_focal));
    All_focal=[All_focal; val1];
    z=size(str_focal);
    z= z(2);
end

z=size(All_focal);
z= z(1);

valeur_final=0;
t=-1;
while z>0
    v= abs(All_focal(1))-95;
    indice = 2^(v-2)+1;
    valeur_final = valeur_final + indice;
    All_focal =All_focal(2:length(All_focal));
    
    z=size(All_focal);
    if(z(2)~=0)
        z= z(1);
    else
        z=0;
    end
    t=t+1;
end
valeur_final=valeur_final-t;
valeur = valeur_final;

%       2     3      4   5    6     7    8   9   10  11  12  13    14   15     16
%       a     b     ab   c    ac   bc   abc  d   ad  bd  abd cd    acd  bcd    abcd  



