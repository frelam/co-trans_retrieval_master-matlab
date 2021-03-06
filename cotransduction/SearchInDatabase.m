function [Results_True]=SearchInDatabase(diff_hog,diff_sift,co_num,item,windows)
%Candidate_Num=candidatenum
%INPUT    
    %item:Query ID In The Database
    %diff_hog:Similiar Matric About Hog feature
    %diff_sift:Similiar Matric About SIFT feature
    %image_list:List of Image Name In the Database
    %co_num:The num of co_image in tow set
    
%OUPUT
    %Results_True
    
%%%%%%%%%%%%%%%%%%%%%%PROGRAM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%Get the candidate items by item's name and bilid the matric image_diff_1 and image_diff_2
                               %compare similiarty accroding to Item_Name and select the most similar 'Candidate_Num' items 
% for i=1:size(image_list,1)
% Text_Similarty_Score(i)=computesimilarity(item_name,image_list(i).name)
% end
% [~,index]=sort(Text_Similarty_Score,'descend')
%  Item_Candidate_Index=index(1:Candidate_Num)  %Item_Candidate_Index:Candidate_Num*1 vector
% image_diff_1=diff_hog(Item_Candidate_Index,Item_Candidate_Index)  %building image_diff_1:50*50 matric
% image_diff_2=diff_sift(Item_Candidate_Index,Item_Candidate_Index)  %building image_diff_2:50*50 matric 
                                  
%Do Co_transduction
%item=1    %默认文本最相似的图像为label过的图像
%WINDOWS=floor(Candidate_Num*0.6)
[Results_True] = co_transduction (diff_hog,diff_sift,co_num,item,windows) 
% [Results_Temp] = co_transduction (image_diff_1,image_diff_2,co_num,item,WINDOWS)      
% Results_True=Item_Candidate_Index(Results_Temp)      %final result : Candidate_Num*1 

