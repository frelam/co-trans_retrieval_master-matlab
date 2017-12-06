function [W]=affinityMatrix_euler(Diff);
% computes an affinity matrix for a given distance matrix
% first
% load F:\TestData\InnerDist\InnerDistanceMatrix.mat
% it loads it to Diff

Diff=(Diff+Diff')/2;
[T,INDEX]=sort(Diff,2);
[m,n]=size(Diff);
W=zeros(m,n);
K=17;
PI=3.1415926;
%----------------------------The parameter for Xingwei's computation----
% for i=1:m
%     for j=1:n
%         SIGMA=mean([T(i,2:K),T(j,2:K)]);
%         W(i,j)=normpdf(Diff(i,j),0,0.4*SIGMA);
%     end
% end
%-------------------The parameter for Haibing's computation------------------------------------------
for i=1:m
    for j=1:n
        SIGMA=mean([T(i,2:K),T(j,2:K)]);
        W(i,j)=normpdf(Diff(i,j),0,0.36*SIGMA);% K=17 and C=0.36 reaches 92%
    end
end
%---------------------------------------------------------------
% W=normpdf(Real_Diff,0,14.2);% the highest is 13.8, the accuracy is 89.78%
% [m,n]=size(W);
   % Norm=repmat(sum(W')',1,n);
   % P=W./Norm;% normalization
   return
%0.27*SIGMA for inner distance matrix for K=10
%0.4*SIGMA for shape part matrix for K=10
%0.2*SIGMA for Face(All) for K=5
%0.4*SIGMA ,K=20 for MPEG7, highest 91.75%
