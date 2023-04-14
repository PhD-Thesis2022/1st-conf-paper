function f = biweight(z)

f = (abs(z)<1).* ((15/16) * (1 - z.^2).^2) ;
end
