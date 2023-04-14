function [ M ] = pignistique( fusionedMasse )
%pignistique calcule les masses des hypothèses simples en utilisant
%la répartition pignistique des masses des hypothèse composites
M = zeros(3,1);
M(1) = fusionedMasse(1) + 0.5*fusionedMasse(4) + 0.5*fusionedMasse(5) + (1/3)*fusionedMasse(7);
M(2) = fusionedMasse(2) + 0.5*fusionedMasse(4) + 0.5*fusionedMasse(6) + (1/3)*fusionedMasse(7);
M(3) = fusionedMasse(3) + 0.5*fusionedMasse(5) + 0.5*fusionedMasse(6) + (1/3)*fusionedMasse(7);
end

