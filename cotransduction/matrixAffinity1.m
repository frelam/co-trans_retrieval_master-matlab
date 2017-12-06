function [W]=matrixAffinity1(W,K);
% computes a new affinity matrix for a given affinity matrix
% K=30 for the 19 ghost points

[m,n]=size(W);
D=diag(sum(W));
W=W./repmat(sum(W,2),1,n);
[YW,IW] = sort(W,2,'descend');
newW1=zeros(m,n);
newW2=zeros(m,n);
for k=1:m
    newW1(k,IW(k,1:K))=W(k,IW(k,1:K));
end
for k=1:3
    NewW=newW1*W*newW1';
    W=NewW;
end