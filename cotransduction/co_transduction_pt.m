function [Results] = co_transduction_pt (Diff_1, Diff_2, p,t,item)
[T_1,INDEX_1] = sort(Diff_1,2);
[T_2,INDEX_2] = sort(Diff_2,2);

NumOfShapes=length(Diff_1);
% Retrieval=zeros(NumOfShapes,Num_retrieval);

correct = 0;


K = 0.25;  
WINDOWS = 300;
Neighbor=14;


    
    
   %-----------Transmition Matrix------------
   TEMP_1 = INDEX_1(item,1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
   Real_Diff_1 = zeros(WINDOWS,WINDOWS);
   Real_Diff_1 = Diff_1(TEMP_1,TEMP_1);% Build up the new matrix for the most WINDOWS similar shapes
   TT_1 = sort(Real_Diff_1,2);
  m = mean( TT_1(:, 2:Neighbor), 2 );
for k=1:WINDOWS% calculate sigma for affinity matrix
    for j=1:WINDOWS
        SIGMA=(m(k)+m(j))/2;;
        W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_1(k,j)^2/2/(K*SIGMA)^2);
    end
end
   [m,n] = size(W);
   Norm = repmat(sum(W')',1,n);
   P_1 = W./Norm;% normalization
    
   
   TEMP_2 = INDEX_2(item,1:WINDOWS);% choose the most WINDOWS similar shapes for the query shape
   Real_Diff_2=zeros(WINDOWS,WINDOWS);
   Real_Diff_2=Diff_2(TEMP_2,TEMP_2);% Build up the new matrix for the most WINDOWS similar shapes
   TT_2=sort(Real_Diff_2,2);
   
   m = mean( TT_2(:, 2:Neighbor), 2 );
for k=1:WINDOWS% calculate sigma for affinity matrix
    for j=1:WINDOWS
        SIGMA=(m(k)+m(j))/2;;
        W(k,j)=1/(sqrt(2*pi)*K*SIGMA)*exp(-Real_Diff_2(k,j)^2/2/(K*SIGMA)^2);
    end
end
   [m,n] = size(W);
   Norm = repmat(sum(W')',1,n);
   P_2 = W./Norm;% normalization
   
   %-----------Label Propogation-------------
   
   [Result1, f1] = Label_Propogation( TEMP_1, P_1, item);   %Result is the array of retrieved sample in a decreasing order
      
   [Result2, f2] = Label_Propogation( TEMP_2, P_2, item);
   
   %-----------Co_Transduction-------------
   for co_num =1:p: 1+p*t
       Co_Sample_2 = Result1(1:co_num);
       Co_Sample_1 = Result2(1:co_num);
       [Result1, f_1] = Label_Propogation( TEMP_1, P_1, Co_Sample_1);%Result is the array of retrieved sample in a decreasing order
       [Result2, f_2] = Label_Propogation( TEMP_2, P_2, Co_Sample_2);
       f1 = f1 + f_1;
       f2 = f2 + f_2;
       f = zeros( 1, NumOfShapes);
   end
   for i = 1:WINDOWS  %f = f1;
       f(TEMP_1(i)) = f1(i);
   end
   for i = 1:WINDOWS   %f = f + f2
       f(TEMP_2(i)) = f(TEMP_2(i)) + f2(i);
   end
   f = f/6;
   [ T, Results] = sort( f, 'descend');