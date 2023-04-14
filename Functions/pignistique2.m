function [ M ] = pignistique2( fusionedMasse )
%pignistique calcule les masses des hypoth�ses simples en utilisant
%la r�partition pignistique des masses des hypoth�se composites
M = zeros(2,1);
M(1) = fusionedMasse(1) + 0.5*fusionedMasse(3) ;
M(2) = fusionedMasse(2) + 0.5*fusionedMasse(3) ;
end