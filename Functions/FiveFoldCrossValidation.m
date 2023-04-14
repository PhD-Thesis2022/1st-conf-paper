

function [ d1,d2,d3,d4,d5 ] = FiveFoldCrossValidation( A )

 indices = crossvalind('Kfold',getnlab(A),5);
 LABELS=getnlab(A);
 
 d1=prdataset( A.data(indices==1,:),LABELS(indices==1));
 d2=prdataset( A.data(indices==2,:),LABELS(indices==2));
 d3=prdataset( A.data(indices==3,:),LABELS(indices==3));
 d4=prdataset( A.data(indices==4,:),LABELS(indices==4));
 d5=prdataset( A.data(indices==5,:),LABELS(indices==5));

end

