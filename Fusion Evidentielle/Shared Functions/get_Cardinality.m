function [Masse]=get_Cardinality(focal)
if(focal == 1)
    Masse= 0;
    return
else if ((focal == 2)|(focal == 3))
        Masse = 1;
        return
    else if (focal == 4)
            Masse =2;
            return
        end
    end
end

res = focal;

%  v   a   b    ab ' c    ac   bc  abc  "d   ad   bd    abd ' cd    acd   bcd  abcd 
%  1   2   3    4  ' 5    6    7    8   "9   10   11    12    13    14    15
% [0   1   1    2  ' 1    2    2    3   "1    2    2     3  '  2     3     3    4]

% Calcul du décalage par rapport au frame de discernement
cmp = 0;
while (res > 2)
    res= res /2 ;
    cmp=cmp+1;
end
taille_discernement  = cmp + 1;
decalage = focal -2^(taille_discernement-1) ;
Cardinality = 1 +  get_Cardinality(decalage);

Masse= Cardinality;