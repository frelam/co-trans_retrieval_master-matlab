function [Results] = triple_transduction (M_Diff, A_1_Diff, A_2_Diff, Co_Num, item)
[T_M, INDEX_M] = sort(M_Diff, 2);
[T_A_1, INDEX_A_1] = sort(A_1_Diff, 2);
[T_A_2, INDEX_A_2] = sort(A_2_Diff, 2);

NumOfShapes=length(M_Diff);

K = 0.25;  
WINDOWS = 350;
Neighbor=14;

%-----------Transmition Matrix of M ------------%
SHAPES_M = INDEX_M(item, 1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
Real_Diff_M = M_Diff(SHAPES_M, SHAPES_M);% Build up the new matrix for the most WINDOWS similar shapes

TT_M = sort(Real_Diff_M,2);
m = mean(TT_M(:, 2:Neighbor), 2);

for k=1:WINDOWS  % calculate sigma for affinity matrix
    for j=1:WINDOWS
        SIGMA=(m(k)+m(j))/2;
        W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_M(k,j)^2/2/(K*SIGMA)^2);
    end
end

% normalization
[m,n] = size(W);
Norm = repmat(sum(W')',1,n);
P_M = W./Norm;
%----------------------------------------------%

%-----------Transmition Matrix of A_1 ------------%
SHAPES_A_1 = INDEX_A_1(item, 1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
Real_Diff_A_1 = A_1_Diff(SHAPES_A_1, SHAPES_A_1);% Build up the new matrix for the most WINDOWS similar shapes

TT_A_1 = sort(Real_Diff_A_1, 2);
m = mean(TT_A_1(:, 2:Neighbor), 2);

for k=1:WINDOWS  % calculate sigma for affinity matrix
    for j=1:WINDOWS
        SIGMA=(m(k)+m(j))/2;
        W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_A_1(k,j)^2/2/(K*SIGMA)^2);
    end
end

% normalization
[m,n] = size(W);
Norm = repmat(sum(W')',1,n);
P_A_1 = W./Norm;
%----------------------------------------------%

%-----------Transmition Matrix of A_2 ------------%
SHAPES_A_2 = INDEX_A_2(item, 1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
Real_Diff_A_2 = A_2_Diff(SHAPES_A_2, SHAPES_A_2);% Build up the new matrix for the most WINDOWS similar shapes

TT_A_2 = sort(Real_Diff_A_2, 2);
m = mean(TT_A_2(:, 2:Neighbor), 2);

for k=1:WINDOWS  % calculate sigma for affinity matrix
    for j=1:WINDOWS
        SIGMA=(m(k)+m(j))/2;
        W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_A_2(k,j)^2/2/(K*SIGMA)^2);
    end
end

% normalization
[m,n] = size(W);
Norm = repmat(sum(W')',1,n);
P_A_2 = W./Norm;
%----------------------------------------------%

%-----------Label Propogation(A->(B,C)->A)------------%   
[Result_M, f_M] = Label_Propogation (SHAPES_M, P_M, item);   %Result is the array of retrieved sample in a decreasing order
[Result_A_1, f_A_1] = Label_Propogation (SHAPES_A_1, P_A_1, item);
[Result_A_2, f_A_2] = Label_Propogation (SHAPES_A_2, P_A_2, item);
%----------------------------------------%
   
% %-----------Triple_Transduction------------% 
% for co_num =1:3: Co_Num
%     % obtain the transduction samples
%     Triple_Sample_M = Result_M (1:co_num);
%     [Result_Common, Common_Count] = ObtainCommon (Result_A_1, Result_A_2);
%     
%     % transduce from M to A_1 and A_2
%     [Result_A_1, f_A_1_T] = Label_Propogation (SHAPES_A_1, P_A_1, Triple_Sample_M);
%     [Result_A_2, f_A_2_T] = Label_Propogation (SHAPES_A_2, P_A_2, Triple_Sample_M);
%     
%     % transduce from A_1 and A_2 to M
%     Triple_Sample_A = Result_Common (1:co_num);
%     [Result_M, f_M_T] = Label_Propogation (SHAPES_M, P_M, Triple_Sample_A);
%     
%     % accumulate similarities
%     f_M = f_M + f_M_T;
%     f_A_1 = f_A_1 + f_A_1_T;
%     f_A_2 = f_A_2 + f_A_2_T;    
% end
% %----------------------------------------%

%-----------Triple_Transduction(A->B->C->A)------------% 
for co_num =1:3: Co_Num
    % obtain the transduction samples
    Triple_Sample_M = Result_M(1:co_num);
    Triple_Sample_A_1 = Result_A_1(1:co_num);
    Triple_Sample_A_2 = Result_A_2(1:co_num);
    
    % transduce from M to A_1
    [Result_A_1, f_A_1_T] = Label_Propogation (SHAPES_A_1, P_A_1, Triple_Sample_M);
    
    % transduce from A_1 to A_2
    [Result_A_2, f_A_2_T] = Label_Propogation (SHAPES_A_2, P_A_2, Triple_Sample_A_1);
    
    % transduce from A_2 to M
    [Result_M, f_M_T] = Label_Propogation (SHAPES_M, P_M, Triple_Sample_A_2);
    
    % accumulate similarities
    f_M = f_M + f_M_T;
    f_A_1 = f_A_1 + f_A_1_T;
    f_A_2 = f_A_2 + f_A_2_T;    
end
%----------------------------------------%

%-----------calculate final similarity------------% 
f = zeros( 1, NumOfShapes); % final similarity(score)

for i = 1:WINDOWS
   f(SHAPES_M(i)) = f_M(i);
end

for i = 1:WINDOWS 
   f(SHAPES_A_1(i)) = f(SHAPES_A_1(i)) + f_A_1(i);
end

for i = 1:WINDOWS 
   f(SHAPES_A_2(i)) = f(SHAPES_A_2(i)) + f_A_2(i);
end

f = f / 6;
f = f / 3;
%----------------------------------------%

% return final result
[T, Results] = sort(f, 'descend');

