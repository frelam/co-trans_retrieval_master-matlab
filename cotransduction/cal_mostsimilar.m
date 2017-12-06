clear
clc

load Label_propagation_Mpeg_sc.mat;
Diff_M_sc=Score;
clear Score;

load Label_propagation_Mpeg_inner.mat;
Diff_M_in=Diff;
clear Diff;

load Diff_Tu.mat;

% load tari100_inner.mat;
% Diff_T_in = dist;
% clear dist;
% 
% load tari100_sc.mat;
% Diff_T_sc=Score;
% clear Score;

for item=1:1400
    item
    [Results] = co_transduction (Diff_M_sc, Diff_M_in, 10,item);
    Retrieval_M_3_coscandinner(item,:)=Results(1:40);
    [Results] = co_transduction (Diff_M_sc, Diff_Tu, 10,item);
    Retrieval_M_3_coscandtu(item,:)=Results(1:40);
    [Results] = co_transduction (Diff_Tu, Diff_M_in, 10,item);
    Retrieval_M_3_cotuandinner(item,:)=Results(1:40);
        [Results] = co_transduction (Diff_M_sc, Diff_M_in, 4,item);
    Retrieval_M_1_coscandinner(item,:)=Results(1:40);
    [Results] = co_transduction (Diff_M_sc, Diff_Tu, 4,item);
    Retrieval_M_1_coscandtu(item,:)=Results(1:40);
    [Results] = co_transduction (Diff_Tu, Diff_M_in, 4,item);
    Retrieval_M_1_cotuandinner(item,:)=Results(1:40);
     [Results]=LP(Diff_M_sc,item);
     Retrieval_M_sclp(item,:)=Results(1:40);
     [Results]=LP(Diff_M_in,item);
     Retrieval_M_inlp(item,:)=Results(1:40);
     [Results]=LP(Diff_Tu,item);
     Retrieval_M_tulp(item,:)=Results(1:40);
end
 save('Retrieval_M','Retrieval_M_3_coscandinner','Retrieval_M_3_coscandtu','Retrieval_M_3_cotuandinner','Retrieval_M_1_coscandinner','Retrieval_M_1_coscandtu','Retrieval_M_1_cotuandinner' ,'Retrieval_M_sclp','Retrieval_M_inlp','Retrieval_M_tulp');
clear Diff_M_sc;
% clear Diff_M_in;
% for item=1:1000
%     item
% %     [Results] = co_transduction (Diff_T_sc, Diff_T_in, 10,item);
% %     Retrieval_T_co(item,:)=Results(1:40);
%     [Results]=LP(Diff_T_sc,item);
%     Retrieval_T_sclp(item,:)=Results(1:40);
%     [Results]=LP(Diff_T_in,item);
%     Retrieval_T_inlp(item,:)=Results(1:40);
% end
% clear Diff_T_sc;
% clear Diff_T_in;
% save('Retrieval_T','Retrieval_T_co','Retrieval_T_sclp','Retrieval_T_inlp'
% ,'Retrieval_T_sc','Retrieval_T_in');