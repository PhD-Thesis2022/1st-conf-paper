function f = Triweight(z)
%Triweight Triweight's asymptotically optimal kernel.
f=(abs(z)<1).*((35/32)*(1-z.^2).^3);
end