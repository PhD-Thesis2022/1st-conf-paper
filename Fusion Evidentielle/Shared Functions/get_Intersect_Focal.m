function [Focal_Id]=get_Intersect_Focal(element1, element2)
% Dans quelle partie se trouve element 1 et 2
card1 = ceil( log2(element1));
card2 = ceil( log2(element2));
if ((element1 <= 4) & (element2 <= 4)) 
    Mat_Intersec_Theta_2 = [1	1	1	1
                            1	2	1	2
                            1	1	3	3
                            1	2	3	4];
    Focal_Id = Mat_Intersec_Theta_2(element1,element2);
    return
else if ((element1 > 4) & (element2 > 4))
        var1 = element1 - 2^(card1-1);
        var2 = element2 - 2^(card2-1);
        if (card1 == card2)
            Focal_Id =   2^(card1-1) + get_Intersect_Focal(var1, var2);
        else if (card1 > card2)
                Focal_Id =    get_Intersect_Focal(var1, element2);
             else if (card1 < card2)
                     Focal_Id =    get_Intersect_Focal(element1, var2);
                 end
            end
        end
    else if((element1 > 4) & (element2 <= 4))
            var1 = element1 - 2^(card1-1);
            Focal_Id =   get_Intersect_Focal(var1, element2);
         else if((element1 <= 4) & (element2 > 4)) 
                 var2 = element2 - 2^(card2-1);
                 Focal_Id =   get_Intersect_Focal(element1, var2);
             end
        end
    end
end