%LDA based One-Shot Similarity Measure
%oss_lda_sA_from_xsn & oss_lda_score for more information
%clear all;
%tradedir=dir('E:\trademark\TrademarkImages\zernike.MAT')
%img='E:\trademark\TrademarkImages\';
clear
clc;
load 'trademark\TrademarkImages\zernike.mat'; 
tradedir = zernike;
XSN = [tradedir(121:163,:);tradedir(274:481,:);tradedir(731:756,:);tradedir(876:1003,:)]';

numofclass=[0,120,43,110,34,67,20,35,52,136,113,26,119,47];%119(12�����)
%һ��      1~120, 120
%����121~163, 
%����      164~273, 110
%�ģ�274~307, 
%�壺308~374
%����375~394, 
%�ߣ�395~429, 
%�ˣ�430~481, 
%�ţ�      482~617,  136
%ʮ��      618~730,  113
%ʮһ��731~756, 
%ʮ����    757~875,  119
%ʮ����876~922, 
%ʮ�ģ�923~1003
cs=cumsum(numofclass);%�ۼ�
%cs = 0   120   163   273   307   374   394   429   481   617   730   756   875��12������   922
%cs(1)=0,cs(2)=120,cs(3)=163...
class=[1,3,9,10,12];
sA = oss_lda_sA_from_xsn(XSN);
% for i=1:1003
%     for j=1:1003
%         Score(i,j)=-10;
%     end
% end
% Score = ones(1003,1003)*(-10);
% for ii=1:5
%     x1_num = class(ii);%��class(ii) - x1_num class�����ͼi�͵�class(jj) - x2_num class�����ͼj�Ա�
%     for jj=1:5  %x1_num��ʾ�ڼ���class��x2_num��ʾ�ڼ���class
%         x2_num = class(jj);
%         for i=1:numofclass(x1_num+1)%numofclassΪ�ڼ���class�����ֵ
%             for j=1:numofclass(x2_num+1)
%                 test_x1 = cs(x1_num)+i;
%                 test_x2 = cs(x2_num)+j;
%                 x1 = tradedir((cs(x1_num))+i,:)';
%                 x2 = tradedir((cs(x2_num))+j,:)';
%                 %if x1~=x2
%                 Score1 = oss_lda_score(x1,x2,sA);
%                 Score2 = oss_lda_score(x2,x1,sA);
%                 Score((cs(x1_num))+i,(cs(x2_num))+j) = (Score1 + Score2)./2;
%                 %end
%             end
%         end
%     end
% end
load('trademark\score_zer.mat');
numofclass=[0,120,43,110,34,67,20,35,52,136,113,26,119,47];
kk=1;
cs=cumsum(numofclass);%�ۼ�
test=[1,3,9,10,12];
correct=0;
N = 0;
m = 0;
for k=1:13
    for i=cs(k)+1:cs(k+1)
        [t,tt]=sort(Score(i,:),'descend');%�Ӵ�С����
        correct_t=0;
        j_end = numofclass(k+1);
%         N = N + numofclass(k+1);
%         m = m + j_end;
        for j=1:j_end
           % if tt(j)==i
            %    j=j+1;
             %   j_end=j_end+1;
            %end
            if ((tt(j)>cs(k))&(tt(j)<=cs(k+1)))
            %if((tt(j)>cs(k))&(tt(j)<=(cs(k)+numofclass(k+1))))    
%                 correct = correct + 1;
                correct_t = correct_t + 1;
            end
        end
        Retrieval_rate(i)=correct_t/numofclass(k+1);
%         Rec(i)=correct_t/(numofclass(k+1));
%         Pre(i)=correct_t/j_end;
    end
%     Rr(k)=mean(Retrieval_rate(cs(k)+1:cs(k+1)));
    %Rr(k)=mean(Retrieval_rate(cs(k)+1:numofclass(k+1)*0.05))
end
recall = correct / N
precision = correct / m
% Result = sum(Rr)/5