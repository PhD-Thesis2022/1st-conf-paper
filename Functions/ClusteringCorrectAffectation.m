function [ D ] = ClusteringCorrectAffectation( A,B)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
k=getsize(A,3);
if k==2

a=B;
a_inv=B;

LABELS=getnlab(B);
for i=1:size(a_inv,1)
    if LABELS(i)==1 
        a_inv = SETNLAB(a_inv,2,i);
    elseif LABELS(i)==2
        a_inv = SETNLAB(a_inv,1,i);
    end
      
end
LABELS_inv=getnlab(a_inv);
a1=sum(LABELS == getnlab(A))/getsize(A,1);
a2=sum(LABELS_inv == getnlab(A))/getsize(A,1);
Max_2=max(a1,a2);
if Max_2==a1
    D= a;
elseif Max_2==a2
   D= a_inv;
end

end

if k==3

a=B;
a123=a;
a132=a;
a213=a;
a231=a;
a312=a;
a321=a;

LABELS=getnlab(a);
LABELS_a123=LABELS;
%
for i=1:size(a132,1)
    if LABELS(i)==1 
        a132 = SETNLAB(a132,1,i);
    elseif LABELS(i)==2
        a132 = SETNLAB(a132,3,i);
    elseif LABELS(i)==3
        a132 = SETNLAB(a132,2,i);
    end
      
end
LABELS_a132=getnlab(a132);
%
for i=1:size(a213,1)
    if LABELS(i)==1 
        a213 = SETNLAB(a213,2,i);
    elseif LABELS(i)==2
        a213 = SETNLAB(a213,1,i);
    elseif LABELS(i)==3
        a213 = SETNLAB(a213,3,i);
    end
      
end
LABELS_a213=getnlab(a213);
%
for i=1:size(a231,1)
    if LABELS(i)==1 
        a231 = SETNLAB(a231,2,i);
    elseif LABELS(i)==2
        a231 = SETNLAB(a231,3,i);
    elseif LABELS(i)==3
        a231 = SETNLAB(a231,1,i);
    end
      
end
LABELS_a231=getnlab(a231);
%

for i=1:size(a312,1)
    if LABELS(i)==1 
        a312 = SETNLAB(a312,3,i);
    elseif LABELS(i)==2
        a312 = SETNLAB(a312,1,i);
    elseif LABELS(i)==3
        a312 = SETNLAB(a312,2,i);
    end
      
end
LABELS_a312=getnlab(a312);
%
for i=1:size(a321,1)
    if LABELS(i)==1 
        a321 = SETNLAB(a321,3,i);
    elseif LABELS(i)==2
        a321 = SETNLAB(a321,2,i);
    elseif LABELS(i)==3
        a321 = SETNLAB(a321,1,i);
    end
      
end
LABELS_a321=getnlab(a321);



a1= sum(LABELS_a123 == getnlab(A))/getsize(A,1);
a2=  sum(LABELS_a132 == getnlab(A))/getsize(A,1);
a3=  sum(LABELS_a213 == getnlab(A))/getsize(A,1);
a4=  sum(LABELS_a231 == getnlab(A))/getsize(A,1);
a5=  sum(LABELS_a312 == getnlab(A))/getsize(A,1);
a6=  sum(LABELS_a321 == getnlab(A))/getsize(A,1);
a=[a1,a2,a3,a4,a5,a6];
Max_3=max(a);
if Max_3==a1
    D=a123;
elseif Max_3==a2
    D=a132;
elseif Max_3==a3
    D=a213;
elseif Max_3==a4
    D=a231;
elseif Max_3==a5
    D=a312;
elseif Max_3==a6
    D=a321;
end

end

end

