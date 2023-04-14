% % ##  Example 1

M_MeanM1_Vecteur=[];
M_MeanConsensus_Vecteur=[];
M_Mean_Vecteur=[];
M_PCR_Vecteur=[];
M_DS_Vecteur=[];
M_WAO_Vecteur=[];

K_Vecteur=[];
Vecteur=[];
Map_MeanM1=[];
Map_MeanConsensus=[];
Map_Mean=[];

a=[];
b=[];


for a=0:0.1:1
    for b=0:0.1:0.5
        m1=[0    a      0    1-a         0              0   0    0]';
        m2=[0    0      0    b          1-b-(b/2)       0   0    b/2]';
            
       
        M_MeanM1 = Mean_M1([m1 m2 ])
        M_MeanConsensus = MeanConsensus([m1 m2 ])
        M_Mean = Mean([m1 m2 ])
        
        M_PCR  =DST([m1 m2 ],8);
        M_DS   =DST([m1 m2 ],2);
        M_WAO  =WAO([m1 m2 ]);
       
        M_MeanM1_Vecteur=[M_MeanM1_Vecteur;a  b  M_MeanM1 ];
        M_MeanConsensus_Vecteur=[M_MeanConsensus_Vecteur;a  b  M_MeanConsensus ];
        M_Mean_Vecteur=[M_Mean_Vecteur;a  b  M_Mean ];
        
        M_PCR_Vecteur=[M_PCR_Vecteur; a  b  M_PCR ];
        M_DS_Vecteur=[M_DS_Vecteur;a  b   M_DS ];
        M_WAO_Vecteur=[M_WAO_Vecteur;a  b  M_WAO ];

       end
end

% Variable to calculate the mass {a=4, b=5, (a,b)=6, c=7, (a,c)=8, (b,c)=9,
% (a,b,c)=10
massnumber =7;

% % MeanM1
a= M_MeanM1_Vecteur(:,1)
b= M_MeanM1_Vecteur(:,2);
Vecteur_MeanM1= M_MeanM1_Vecteur(:,massnumber); 
[a,b] = meshgrid(0:.1:0.5,0:.1:1)

l=0;
for i=1:6:size(Vecteur_MeanM1)
    l=l+1;
    for k=0:5
       Map_MeanM1(l,k+1)=Vecteur_MeanM1(i+k);
    end
end

% % MeanConsensus
a= M_MeanConsensus_Vecteur(:,1)
b= M_MeanConsensus_Vecteur(:,2);
Vecteur_MeanConsensus= M_MeanConsensus_Vecteur(:,massnumber); 
[a,b] = meshgrid(0:.1:0.5,0:.1:1)

l=0;
for i=1:6:size(Vecteur_MeanConsensus)
    l=l+1;
    for k=0:5
       Map_MeanConsensus(l,k+1)=Vecteur_MeanConsensus(i+k);
    end
end

% % Mean
a= M_Mean_Vecteur(:,1)
b= M_Mean_Vecteur(:,2);
Vecteur_Mean= M_Mean_Vecteur(:,massnumber); 
[a,b] = meshgrid(0:.1:0.5,0:.1:1)

l=0;
for i=1:6:size(Vecteur_Mean)
    l=l+1;
    for k=0:5
       Map_Mean(l,k+1)=Vecteur_Mean(i+k);
    end
end



% PCR   6
r1 = M_PCR_Vecteur(:, 1);
r2 = M_PCR_Vecteur(:, 2);
Vecteur_PCR= M_PCR_Vecteur(:,massnumber);
[a,b] = meshgrid(0:.1:0.5,0:.1:1);

l=0;
for i=1:6:size(Vecteur_PCR)
    l=l+1;
    for k=0:5
        Map_PCR(l,k+1)=Vecteur_PCR(i+k);
    end
end



% DS  (Dempster) 
r1= M_DS_Vecteur(:,1);
r2= M_DS_Vecteur(:,2);
Vecteur_DS= M_DS_Vecteur(:,massnumber);
[a,b] = meshgrid(0:.1:0.5,0:.1:1);

l=0;
for i=1:6:size(Vecteur_DS)
    l=l+1;
    for k=0:5
        Map_DS(l,k+1)=Vecteur_DS(i+k);
    end
end


% WAO  (Dempster) 
r1= M_WAO_Vecteur(:,1);
r2= M_WAO_Vecteur(:,2);
Vecteur_WAO= M_WAO_Vecteur(:,massnumber);
[a,b] = meshgrid(0:.1:0.5,0:.1:1);

l=0;
for i=1:6:size(Vecteur_WAO)
    l=l+1;
    for k=0:5
        Map_WAO(l,k+1)=Vecteur_WAO(i+k);
    end
end



figure;surfc(a,b,Map_MeanM1);
title('') 
xlabel('b') 
ylabel('a')
zlabel('m_{12|WAMO_{1}}(C)')
shading flat
colormap hsv

figure;surfc(a,b,Map_MeanConsensus);
title('') 
xlabel('b') 
ylabel('a')
zlabel('m_{12|WAMO_{2}}(C)')
shading flat
colormap hsv

figure;surfc(a,b,Map_Mean);
title('') 
xlabel('b') 
ylabel('a')
zlabel('m_{12|WAMO_{3}}(C)')
shading flat
colormap hsv



figure;surfc(a,b,Map_PCR);
title('') 
xlabel('b') 
ylabel('a')
zlabel('m_{12|PCR6}(C)')
shading flat
colormap hsv

figure;surfc(a,b,Map_DS);
title('') 
xlabel('b') 
ylabel('a')
zlabel('m_{12|DS}(C)')
shading flat
colormap hsv

figure;surfc(a,b,Map_WAO);
title('') 
xlabel('b') 
ylabel('a')
zlabel('m_{12|WAO}(C)')
shading flat
colormap hsv