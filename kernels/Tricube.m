function f = Tricube(z)

f=(abs(z)<1).*((70/81)*(1-abs(z).^3).^3);
end