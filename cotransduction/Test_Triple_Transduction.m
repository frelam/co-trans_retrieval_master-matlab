%Test Triple_Transduction
load Diff_Tu.mat;                         %% variable : Diff_Tu
load Label_propagation_Mpeg_sc.mat;       %% variable : Score
load Label_propagation_Mpeg_inner.mat     %% variable : Diff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   A->(B,C)->A->(B,C)...
%%                    N =  300      350       400        
%% result : tu_sc_inner = 0.9864   0.9876    0.9878    
%% result : tu_inner_sc = 0.9875   0.9892    0.9900
%% result : sc_tu_inner = 0.9865   0.9873    0.9880
%% result : sc_inner_tu = 0.9861   0.9894    0.9901
%% result : inner_tu_sc = 0.9881   0.9904    0.9907
%% result : inner_sc_tu = 0.9863   0.9895    0.9902
%%                 mean = 0.9868   0.9889    

%%   A->B->C->A->B->C...
%%                    N =  300      350    
%% result : tu_sc_inner = 0.9886   0.9906
%% result : tu_inner_sc =          0.9904
%% result : sc_tu_inner =          0.9904
%% result : sc_inner_tu =          0.9906
%% result : inner_tu_sc =          0.9906
%% result : inner_sc_tu =          0.9904
%%                 mean =    
%%

% for item = 1 : 1400
%     item
%     [Results] = triple_transduction (Diff_Tu, Score, Diff, 10, item);
%     Retrieval_M_Triple_tu_sc_inner(item,:)=Results(1:40);
% end
% save('Retrieval_M_Triple_tu_sc_inner')

% for item = 1 : 1400
%     item
%     [Results] = triple_transduction (Diff_Tu, Diff, Score, 10, item);
%     Retrieval_M_Triple_tu_inner_sc(item,:)=Results(1:40);
% end
% save('Retrieval_M_Triple_tu_inner_sc')

for item = 1 : 1400
    item
    [Results] = triple_transduction (Score, Diff_Tu, Diff, 10, item);
    Retrieval_M_Triple_sc_tu_inner(item,:)=Results(1:40);
end
save('Retrieval_M_Triple_sc_tu_inner')

for item = 1 : 1400
    item
    [Results] = triple_transduction (Score, Diff, Diff_Tu, 10, item);
    Retrieval_M_Triple_sc_inner_tu(item,:)=Results(1:40);
end
save('Retrieval_M_Triple_sc_inner_tu')

for item = 1 : 1400
    item
    [Results] = triple_transduction (Diff, Diff_Tu, Score, 10, item);
    Retrieval_M_Triple_inner_tu_sc(item,:)=Results(1:40);
end
save('Retrieval_M_Triple_inner_tu_sc')

for item = 1 : 1400
    item
    [Results] = triple_transduction (Diff, Score, Diff_Tu, 10, item);
    Retrieval_M_Triple_inner_sc_tu(item,:)=Results(1:40);
end
save('Retrieval_M_Triple_inner_sc_tu')
