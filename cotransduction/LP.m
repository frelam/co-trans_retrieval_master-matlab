function [Results]=LP(Diff,item);
%
%
WINDOWS=300;
% load Label_propagation_Mpeg;
% load Label_propagation_Mpeg_inner.mat
NumOfShapes=1400;% 
Num_retrieval=40;
NO_ShapeClass=20;
Diff=(Diff+Diff')/2;
[T,INDEX]=sort(Diff,2);
[m,n]=size(Diff);
Retrieval=zeros(NumOfShapes,Num_retrieval);
correct=0;
K=0.25;
Neighbor=14;


    TEMP=INDEX(item,1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
    Real_Diff=zeros(WINDOWS,WINDOWS);
    Real_Diff=Diff(TEMP,TEMP);% Build up the new matrix for the most WINDOWS similar shapes
    TT=sort(Real_Diff,2);
    m = mean( TT(:, 2:Neighbor), 2 );
for k=1:WINDOWS% calculate sigma for affinity matrix
    for j=1:WINDOWS
        SIGMA=(m(k)+m(j))/2;;
        W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff(k,j)^2/2/(K*SIGMA)^2);
    end
end
    [m,n]=size(W);
    Norm=repmat(sum(W')',1,n);
    P=W./Norm;% normalization
    f=zeros(WINDOWS,1);
    %------------------ Learning the distance-------------------------
    f(1)=1;
    for k=1:1000
        f=P*f;
        f(1)=1;
    end
    [TT,TEMP_R]=sort(f,'descend');
    Results=TEMP(TEMP_R);
   
    

