
function prdata=load_prdataset(filename,nbratt,class,att_debut,att_fin)
%filname : c'est un  "fichier.dat" a télécharger de UCI repositery  
%nbratt : nombre d'attribut a partir de la descreptin dans UCI
%att_debut et att_fin indice de la premier attribut et du dernier 
%remerque: Dans les "fichier.dat" des fois la coloune des labels des classe est la derniere 
%contrairement au dataset de prtools 

%hepatitis=load_prdataset('hepatitis.dat',20,1,2,20);
%australian=load_prdataset('australian.dat',15,15,1,14);


fmt = repmat('%f',1,nbratt);
fid = fopen(filename, 'rt');
datacell = textscan(fid, fmt, 'delimiter', ',','TreatAsEmpty', '?', 'CollectOutput', 1);
fclose(fid);
prclass = datacell{1}(:,class);
prattrib = datacell{1}(:,att_debut:att_fin);
prdata = prdataset( prattrib, prclass );
end