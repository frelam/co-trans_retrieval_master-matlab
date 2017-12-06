% clear
 clc
% 
load Label_propagation_Mpeg_sc.mat;
Diff_M_sc=Score;
clear Score;

load Label_propagation_Mpeg_inner.mat;
Diff_M_in=Diff;
clear Diff;

% load Diff_Tu.mat;

% load tari100_inner.mat;
% Diff_T_in = dist;
% clear dist;
%
% load tari100_sc.mat;
% Diff_T_sc=Score;
% clear Score;
for p = 5
    p
    for t = 4:5
        t
        for item=1:1400
             item
            [Results] = co_transduction_pt (Diff_M_sc, Diff_M_in, p,t,item);
            Retrieval_M_coscandinner(item,:)=Results(1:40);
            correct = 0 ;
            for j=1:40

                if (ceil(item/20)==ceil(Results(j)/20))
                    correct = correct +1 ;
                end
            end
            rate(item)=correct/20;

        end
        
        ratept(p,t)=mean(rate);
        
    end
end
        
        
