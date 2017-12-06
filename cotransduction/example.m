%% Examples for co-transduction and tri-transduction
% load affinity matrices 
clear all;
load Diff_Tu.mat;                         %% variable : Diff_Tu
load Label_propagation_Mpeg_sc.mat;       %% variable : Score
load Label_propagation_Mpeg_inner.mat     %% variable : Diff

%% test co-transduction
for item = 1 : 1400
    item
    [Results] = co_transduction (Diff_Tu, Score, 10, item);
    Retrieval_M_co_Tuandsc(item,:)=Results(1:40);
end
save('Retrieval_M_co_Tuandsc')

% evaluation
[accuracy] = Evaluation ('Retrieval_M_co_Tuandsc.mat');
accuracy

%% test tri-transduction
for item = 1 : 1400
    item
    [Results] = triple_transduction (Diff_Tu, Score, Diff, 10, item);
    Retrieval_M_Triple_tu_sc_inner(item,:)=Results(1:40);
end
save('Retrieval_M_Triple_tu_sc_inner')

% evaluation
[accuracy] = Evaluation ('Retrieval_M_Triple_tu_sc_inner.mat');
accuracy
