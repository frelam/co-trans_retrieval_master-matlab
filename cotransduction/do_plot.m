% clear
% clc
% 
% load Label_propagation_Mpeg_sc.mat;
% Diff_M_sc=Score;
% clear Score;
% 
% load Label_propagation_Mpeg_inner.mat;
% Diff_M_in=Diff;
% clear Diff;
% 
% load Diff_Tu.mat;
 load Retrieval_M.mat
% 
% for i = 1:1400
%     [t,tt] = sort( Diff_M_sc(i,:) );
%     Retrieval_M_sc(i,:) = tt(1:40);
%     [t,tt] = sort( Diff_M_in(i,:));
%     Retrieval_M_in(i,:) = tt(1:40);
%     [t,tt] = sort( Diff_Tu(i,:) );
%     Retrieval_M_tu(i,:) = tt(1:40);
% end
% save('Retrieval_M','Retrieval_M_sc','Retrieval_M_in','Retrieval_M_tu','Retrieval_M_3_coscandinner','Retrieval_M_3_coscandtu','Retrieval_M_3_cotuandinner','Retrieval_M_1_coscandinner','Retrieval_M_1_coscandtu','Retrieval_M_1_cotuandinner' ,'Retrieval_M_sclp','Retrieval_M_inlp','Retrieval_M_tulp');

for i=1:1400
      for j=1:40
	  
	  Rr_co_scandinner(i,j)=ceil(Retrieval_M_3_coscandinner(i,j)/20)==ceil(i/20);
      Rr_co_scandtu(i,j)=ceil(Retrieval_M_3_coscandtu(i,j)/20)==ceil(i/20);
      Rr_co_tuandinner(i,j)=ceil(Retrieval_M_3_cotuandinner(i,j)/20)==ceil(i/20);
	  Rr_sclp(i,j)=ceil(Retrieval_M_sclp(i,j)/20)==ceil(i/20);
	  Rr_sc(i,j)=ceil(Retrieval_M_sc(i,j)/20)==ceil(i/20);
	  Rr_inlp(i,j)=ceil(Retrieval_M_inlp(i,j)/20)==ceil(i/20);
	  Rr_in(i,j)=ceil(Retrieval_M_in(i,j)/20)==ceil(i/20);
      Rr_tulp(i,j)=ceil(Retrieval_M_tulp(i,j)/20)==ceil(i/20);
	  Rr_tu(i,j)=ceil(Retrieval_M_tu(i,j)/20)==ceil(i/20);
	  end
 end
 for i=1:40
      rate_co_scandinner(i)=sum(sum(Rr_co_scandinner(:,1:i)))/1400/min(i,20);
      rate_co_scandtu(i)=sum(sum(Rr_co_scandtu(:,1:i)))/1400/min(i,20);
      rate_co_tuandinner(i)=sum(sum(Rr_co_tuandinner(:,1:i)))/1400/min(i,20);
	  rate_sclp(i)=sum(sum(Rr_sclp(:,1:i)))/1400/min(i,20);
	  rate_sc(i)=sum(sum(Rr_sc(:,1:i)))/1400/min(i,20);
	  rate_inlp(i)=sum(sum(Rr_inlp(:,1:i)))/1400/min(i,20);
	  rate_in(i)=sum(sum(Rr_in(:,1:i)))/1400/min(i,20);
      rate_tulp(i)=sum(sum(Rr_tulp(:,1:i)))/1400/min(i,20);
	  rate_tu(i)=sum(sum(Rr_tu(:,1:i)))/1400/min(i,20);
 end
% 	  rate_co(40),rate_sclp(40),rate_inlp(40),rate_sc(40),rate_in(40)

	  x=1:40;
	  plot(x,rate_co_scandinner,'ro-',x,rate_sclp,'b+-',x,rate_inlp,'k>-',x,rate_sc,'g*-',x,rate_in,'ms-')
	  axis([0 40 0.6 1])
      xlabel('number of most similar shapes')
      ylabel('percentage of correct results')
 	  legend('Co-transduction','SC+LP','IDSC+LP','SC','IDSC')
	

       	   
	  
	  
	  