%Exemple 1 

m1=[0   1   0   0    0    0    0    0]';
m2=[0   1   0   0    0    0    0    0]';
[conjunctive_masses Conflict] = Conjunction_and_Conflict([m1 m2])

M_DS   =DST([m1 m2 ],2)
M_Murphy             = Murphy([m1 m2 ])
M_Yager   =DST([m1 m2 ],3)
M_Disjunctive   =DST([m1 m2 ],4)
M_Dubois_and_Prade   =DST([m1 m2 ],6)

M_PCR6   =DST([m1 m2 ],8)
M_PCR6_by_SEBBAK = PCR6_by_SEBBAK([m1 m2 ])

%Exemple 1 with Convert_Masses
m1='  a(0.5)    ab(0.5)';
m2='  c(0.5)     bc(0.5)';
m1= Convert_Masses(m1,3)
m2= Convert_Masses(m2,3)
[conjunctive_masses Conflict] = Conjunction_and_Conflict([m1 m2])

M_DS   =DST([m1 m2 ],2)
M_Murphy             = Murphy([m1 m2 ])
M_Yager   =DST([m1 m2 ],3)
M_Disjunctive   =DST([m1 m2 ],4)
M_Dubois_and_Prade   =DST([m1 m2 ],6)
M_PCR6   =DST([m1 m2 ],8)

Decision_Pl =  decisionDST(M_PCR6',1)
Decision_Cr =  decisionDST(M_PCR6',2)
Decision_BetP =  decisionDST(M_PCR6',4)
%##########################################################################
%##########################################################################
%##########################################################################




%##########################################################################
% Disappearing ignorance
%##########################################################################
m1='  a(0.5)    b(0.5)';
m2='  ab(1)';
m1= Convert_Masses(m1,2)
m2= Convert_Masses(m2,2)

M_DS   =DST([m1 m2 ],2)
M_Murphy             = Murphy([m1 m2 ])
M_Yager   =DST([m1 m2 ],3)
M_Disjunctive   =DST([m1 m2 ],4)
M_Dubois_and_Prade   =DST([m1 m2 ],6)
M_PCR6   =DST([m1 m2 ],8)
M_SEBBAK_WAMO_V1 = WAMO([m1 m2],1)
M_SEBBAK_WAMO_V2 = WAMO([m1 m2],2)
M_SEBBAK_WAMO_V3 = WAMO([m1 m2],3)
M_SEBBAK_CRC = CRC([m1 m2])
M_SEBBAK_CREC = CREC([m1 m2])
M_SEBBAK_PCCR = PCCR([m1 m2])
M_SEBBAK_TCR2 = TCR2([m1 m2])
M_SEBBAK_TCR1 = TCR1([m1 m2])
M_SEBBAK_MCR = MCR([m1 m2])




%##########################################################################
% Certainty convergence
%##########################################################################
m1='  a(0.5)    b(0.5)';
m2='  a(0.5)    ab(0.5)';
m1= Convert_Masses(m1,2)
m2= Convert_Masses(m2,2)

M_DS   =DST([m1 m2 ],2)
M_Murphy             = Murphy([m1 m2 ])
M_Yager   =DST([m1 m2 ],3)
M_Disjunctive   =DST([m1 m2 ],4)
M_Dubois_and_Prade   =DST([m1 m2 ],6)
M_PCR6   =DST([m1 m2 ],8)
M_SEBBAK_WAMO_V1 = WAMO([m1 m2],1)
M_SEBBAK_WAMO_V2 = WAMO([m1 m2],2)
M_SEBBAK_WAMO_V3 = WAMO([m1 m2],3)
M_SEBBAK_CRC = CRC([m1 m2])
M_SEBBAK_CREC = CREC([m1 m2])
M_SEBBAK_PCCR = PCCR([m1 m2])
M_SEBBAK_TCR2 = TCR2([m1 m2])
M_SEBBAK_TCR1 = TCR1([m1 m2])
M_SEBBAK_MCR = MCR([m1 m2])


%##########################################################################
% Total certainty to minority opinion
%##########################################################################
m1='  a(0.99)    b(0.01)';
m2='             b(0.01)   c(0.99)';
m1= Convert_Masses(m1,3)
m2= Convert_Masses(m2,3)

M_DS   =DST([m1 m2 ],2)
M_Murphy             = Murphy([m1 m2 ])
M_Yager   =DST([m1 m2 ],3)
M_Disjunctive   =DST([m1 m2 ],4)
M_Dubois_and_Prade   =DST([m1 m2 ],6)
M_PCR6   =DST([m1 m2 ],8)
M_SEBBAK_WAMO_V1 = WAMO([m1 m2],1)
M_SEBBAK_WAMO_V2 = WAMO([m1 m2],2)
M_SEBBAK_WAMO_V3 = WAMO([m1 m2],3)
M_SEBBAK_CRC = CRC([m1 m2])
M_SEBBAK_CREC = CREC([m1 m2])
M_SEBBAK_PCCR = PCCR([m1 m2])
M_SEBBAK_TCR2 = TCR2([m1 m2])
M_SEBBAK_TCR1 = TCR1([m1 m2])
M_SEBBAK_MCR = MCR([m1 m2])


%##########################################################################
% Loss of majority opinion
%##########################################################################
m1='  a(0.9)    ac(0.1)';
m2='  a(0.7)            abc(0.3)';
m3='        b(0.5) c(0.5)';
m1= Convert_Masses(m1,3)
m2= Convert_Masses(m2,3)
m3= Convert_Masses(m3,3)

M_DS   =DST([m1 m2 m3 ],2)
M_Murphy             = Murphy([m1 m2 m3])
M_Yager   =DST([m1 m2 m3],3)
M_Disjunctive   =DST([m1 m2 m3],4)
M_Dubois_and_Prade   =DST([m1 m2 m3],6)
M_PCR6   =DST([m1 m2 m3],8)
M_SEBBAK_WAMO_V1 = WAMO([m1 m2 m3],1)
M_SEBBAK_WAMO_V2 = WAMO([m1 m2 m3],2)
M_SEBBAK_WAMO_V3 = WAMO([m1 m2 m3],3)
M_SEBBAK_CRC = CRC([m1 m2 m3])
M_SEBBAK_CREC = CREC([m1 m2 m3])
M_SEBBAK_PCCR = PCCR([m1 m2 m3])
M_SEBBAK_TCR2 = TCR2([m1 m2 m3])
M_SEBBAK_TCR1 = TCR1([m1 m2 m3])
M_SEBBAK_MCR = MCR([m1 m2 m3])


%##########################################################################
% Unwarranted / Unearned mass
%##########################################################################
m1='  a(0.5)    bc(0.5)';
m2='         ab(0.5)   c(0.5)';
m1= Convert_Masses(m1,3)
m2= Convert_Masses(m2,3)

M_DS   =DST([m1 m2 ],2)
M_Murphy             = Murphy([m1 m2 ])
M_Yager   =DST([m1 m2 ],3)
M_Disjunctive   =DST([m1 m2 ],4)
M_Dubois_and_Prade   =DST([m1 m2 ],6)
M_PCR6   =DST([m1 m2 ],8)
M_SEBBAK_WAMO_V1 = WAMO([m1 m2],1)
M_SEBBAK_WAMO_V2 = WAMO([m1 m2],2)
M_SEBBAK_WAMO_V3 = WAMO([m1 m2],3)
M_SEBBAK_CRC = CRC([m1 m2])
M_SEBBAK_CREC = CREC([m1 m2])
M_SEBBAK_PCCR = PCCR([m1 m2])
M_SEBBAK_TCR2 = TCR2([m1 m2])
M_SEBBAK_TCR1 = TCR1([m1 m2])
M_SEBBAK_MCR = MCR([m1 m2])
