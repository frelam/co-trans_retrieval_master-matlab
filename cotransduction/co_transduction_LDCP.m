% function [Results] = co_transduction_LDCP (Diff_1, Diff_2, Co_Num,item)
clear;
clc;
Co_Num = 1;
load Label_propagation_Mpeg_sc.mat;
load Label_propagation_Mpeg_inner.mat
K=15;
Diff_1 = (Diff+Diff')/2;
Diff_2 = (Score+Score')/2;
load W1
load W2
% W1=affinityMatrix(Diff_1);
% W2 = affinityMatrix(Diff_2);



newW1=matrixAffinity1(W1,15);

maxW1=max(newW1,[],2);
 [YW1,IW1] = sort(repmat(maxW1,1,1400)-newW1,2);
 
 newW2=matrixAffinity1(W2,15);

maxW2=max(newW2,[],2);
 [YW2,IW2] = sort(repmat(maxW2,1,1400)-newW2,2);
 
% W1=W1./repmat(sum(W1,2),1,n);
% W2=W2./repmat(sum(W2,2),1,n);
% 
% [YW1,IW1] = sort(W1,2,'descend');
% newW1=zeros(m,n);
% for k=1:m
%     newW1(k,IW1(k,1:K))=W1(k,IW1(k,1:K));
% end
% for k=1:3
%     NewW1=newW1*W1*newW1';
%     W1=NewW1;
% end
% 
% maxW1=max(W1,[],2);
%  [YW1,IW1] = sort(repmat(maxW1,1,1400)-W1,2);
% 
% [YW2,IW2] = sort(W2,2,'descend');
% newW2=zeros(m,n);
% for k=1:m
%     newW2(k,IW2(k,1:K))=W2(k,IW2(k,1:K));
% end
% for k=1:3
%     NewW2=newW2*W2*newW2';
%     W2=NewW2;
% end
% 
% maxW2=max(W2,[],2);
%  [YW2,IW2] = sort(repmat(maxW2,1,1400)-W2,2);
 ii = 1;
 for co_num =1:2: Co_Num
     for item = 1:size(Diff_1,1)
           Co_Sample_2 = IW1(item,1:co_num);
           Co_Sample_1 = IW2(item,1:co_num);
           W1(item, Co_Sample_1) = max(W1(item,:));
           W1(Co_Sample_1, 1) = max(W1(item,:));

           W2(item, Co_Sample_2) = max(W2(item,:));
           W2(Co_Sample_2, item) = max(W2(item,:));
     end
       
     
     WS{ii} = (W1 + W2) / 2;
     ii = ii + 1;
     
       newW1=matrixAffinity1(W1,15);
        maxW1=max(newW1,[],2);
        [YW1,IW1] = sort(repmat(maxW1,1,1400)-newW1,2);
 
        newW2=matrixAffinity1(W2,15);
        maxW2=max(newW2,[],2);
        [YW2,IW2] = sort(repmat(maxW2,1,1400)-newW2,2);
%        [Result1, f_1] = Label_Propogation( TEMP_1, P_1, Co_Sample_1);%Result is the array of retrieved sample in a decreasing order
%        [Result2, f_2] = Label_Propogation( TEMP_2, P_2, Co_Sample_2);
%        f1 = f1 + f_1;
%        f2 = f2 + f_2;
%        f = zeros( 1, NumOfShapes);
 end
%    W = (W1 + W2) / 2;
% W = W1;
for i = 1:length(WS)
    W = WS{i};
   maxW=max(W,[],2);
        [YW,IW] = sort(repmat(maxW,1,1400)-W,2);
 Retrieval=IW(:,1:40); %retrieval accuracy of the similarity based on the Inner Distance 


N=1400;
StepNumber=5;

NoShapes=20; %for MPEG7
NoClasses=70;

for cind=1:NoClasses
    correct=0;
    for item=1:NoShapes 
        query=(cind-1)*20+item; %query is the query index
%         [simlistind,simlist,fI] = timecomp2(query,YW,IW,N,StepNumber); 
%         Retrieval(query,:)=fI(1,1:40); 
        for t=1:40
            if ceil(query/20)==ceil(Retrieval(query,t)/20)
                correct=correct+1;
            end
        end
    end
    ClassAccuracy(cind)=correct/(20*NoShapes);
end
%save Class_unsupervised_ghost ClassAccuracy;
mean(ClassAccuracy)
end
% [T_1,INDEX_1] = sort(Diff_1,2);
% [T_2,INDEX_2] = sort(Diff_2,2);
% 
% NumOfShapes=length(Diff_1);
% % Retrieval=zeros(NumOfShapes,Num_retrieval);
% 
% correct = 0;
% 
% 
% K = 0.25;  
% WINDOWS = 300;
% Neighbor=14;
% 
% 
%     
%     
%    %-----------Transmition Matrix------------
%    TEMP_1 = INDEX_1(item,1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
%    Real_Diff_1 = zeros(WINDOWS,WINDOWS);
%    Real_Diff_1 = Diff_1(TEMP_1,TEMP_1);% Build up the new matrix for the most WINDOWS similar shapes
%    TT_1 = sort(Real_Diff_1,2);
%   m = mean( TT_1(:, 2:Neighbor), 2 );
% for k=1:WINDOWS% calculate sigma for affinity matrix
%     for j=1:WINDOWS
%         SIGMA=(m(k)+m(j))/2;;
%         W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_1(k,j)^2/2/(K*SIGMA)^2);
%     end
% end
%    [m,n] = size(W);
%    Norm = repmat(sum(W')',1,n);
%    P_1 = W./Norm;% normalization
%     
%    
%    TEMP_2 = INDEX_2(item,1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
%    Real_Diff_2=zeros(WINDOWS,WINDOWS);
%    Real_Diff_2=Diff_2(TEMP_2,TEMP_2);% Build up the new matrix for the most WINDOWS similar shapes
%    TT_2=sort(Real_Diff_2,2);
%    
%    m = mean( TT_2(:, 2:Neighbor), 2 );
% for k=1:WINDOWS% calculate sigma for affinity matrix
%     for j=1:WINDOWS
%         SIGMA=(m(k)+m(j))/2;;
%         W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_2(k,j)^2/2/(K*SIGMA)^2);
%     end
% end
%    [m,n] = size(W);
%    Norm = repmat(sum(W')',1,n);
%    P_2 = W./Norm;% normalization
%    
%    %-----------Label Propogation-------------
%    
%    [Result1, f1] = Label_Propogation( TEMP_1, P_1, item);   %Result is the array of retrieved sample in a decreasing order
%       
%    [Result2, f2] = Label_Propogation( TEMP_2, P_2, item);
%    
%    %-----------Co_Transduction-------------
%    for co_num =1:3: Co_Num
%        Co_Sample_2 = Result1(1:co_num);
%        Co_Sample_1 = Result2(1:co_num);
%        [Result1, f_1] = Label_Propogation( TEMP_1, P_1, Co_Sample_1);%Result is the array of retrieved sample in a decreasing order
%        [Result2, f_2] = Label_Propogation( TEMP_2, P_2, Co_Sample_2);
%        f1 = f1 + f_1;
%        f2 = f2 + f_2;
%        f = zeros( 1, NumOfShapes);
%    end
%    for i = 1:WINDOWS  %f = f1;
%        f(TEMP_1(i)) = f1(i);
%    end
%    for i = 1:WINDOWS   %f = f + f2
%        f(TEMP_2(i)) = f(TEMP_2(i)) + f2(i);
%    end
%    f = f/6;
%    [ T, Results] = sort( f, 'descend');