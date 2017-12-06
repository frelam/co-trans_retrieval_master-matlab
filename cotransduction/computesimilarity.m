function valmax=computesimilarity(A,B)
na=length(A)+1;
nb=length(B)+1;
C=zeros(nb,na); 
for i=1:nb  
    C(i,1)=0; 
end 
for j=1:na   
    C(1,j)=0;
end  
for i=2:nb   
    for j=2:na 
        if B(i-1)==A(j-1) 
            C(i,j)=C(i-1,j-1)+1;      
        else if C(i-1,j)>=C(i,j-1)          
                C(i,j)=C(i-1,j);           
            else 
                C(i,j)=C(i,j-1);             
            end
        end
    end
end
maxval=max(na,nb)
valmax=(C(nb,na))/(maxval-1);
