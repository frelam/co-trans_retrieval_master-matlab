function [accuracy] = Evaluation (recordfilename)

clear;
load (recordfilename); 
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
accuracy = mean(ClassAccuracy);
%save Retrieval_Inner_Diffusion2 Retrieval;

end