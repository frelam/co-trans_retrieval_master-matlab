% for Visual Parts:
% load RESULTMATRIX_flt.txt
% Diff=reshape(RESULTMATRIX_flt,1400,1400);
% or load F:\TestData\ShapeData\VisualPartsMatrix.mat 
% Diff=(Diff+Diff')/2; [T,INDEX]=sort(Diff,2); Retrieval=INDEX(:,1:40);
% for Inner Distance
% load InnerDistanceMatrix.mat; %loads to Diff
%load Label_propagation_Mpeg;

% load Label_propagation_Mpeg_inner.mat;
%Diff=Retrieval_M_Triple_tu_sc_inner;
%Diff=(Diff+Diff')/2;
% create affinity matrix:
%[W]=affinityMatrix(Diff);
% load W2;
% W = W2;
%save TempW W;
%load TempW;
%W=normpdf(Diff,0,5);
% or load W direclty by load IDAffinityMatrix.mat  or  by load VPAffinityMatrix.mat
%[newW]=NewAffinity3diff(W);
%[newW]=NewAffinity1diff(W);
%[newW,Difference]=NewAffinity1(W);
%newW=CommuteTimeShape(W);
%newW=matrixAffinity1(W,15);% best is K=15 and iteration is 3
%save Sim_Origi_Diffusion;
 %maxW=max(newW,[],2);
 %[YW,IW] = sort(repmat(maxW,1,1400)-newW,2); %converts similarities to
% distances

%Retrieval - sorted matrix of most similar indices of size 1400 x 40
% Retrieval=zeros(1400,40); %comment for original accuracy
%Retrieval=IW(:,1:40); %retrieval accuracy of the similarity based on the Inner Distance 

clear;
load Retrieval_M_Triple_inner_sc_tu.mat; 
Retrieval = Retrieval_M_Triple_inner_sc_tu;
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
%save Retrieval_Inner_Diffusion2 Retrieval;