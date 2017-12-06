%          检索主函数
% INPUT               %%%
% 两个特征图像的关系矩阵 n*n
% 1.基于HOG特征关系矩阵，相似度用余弦角度量，diff_hog
% 2.基于SIFT特征关系矩阵，相似度用余弦角度量,diff_sift
% 需要图像数据库的名字列表 ImageNameList
clear all
% load image_hog_diff.mat            %diff_hog
% load image_sift_diff.mat           %diff_sift
load CNN_diff_final.mat
load image_hog_diff_corel1000.mat
load image_lbp_diff_orilbp_corel1000.mat
load image_phog_diff_corel1000.mat
load ImageNameList_corel1000.mat
%load ImageNameList.mat       %image_list
addpath 'J:\慧敏师姐\test1-corel1000\image.orig'
NumShow=40   %文字搜索结果候选图片数目
%ItemName='002_building_building_238.jpg' %检索图片的英文名字
item = 464 
Co_num=15        %互训练的
windows = 300
image_list=ImageNameList
diff_hog=image_lbp_diff
diff_sift=image_hog_diff

m1=size(diff_hog,2)
m2=size(diff_sift,2)

%CandidateNum=NumShow

Results=SearchInDatabase(diff_hog,diff_sift,Co_num,item,windows)%Results = NumShow*1 vector
Results1=co_transduction_original (diff_hog, diff_sift, Co_num,item,windows)
%%%%%%%%%%show image%%%%%%%%%%%
imName1=image_list(item).name
I2 = uint8(zeros(100, 100, 3, NumShow))
for i=1:NumShow
    imName=image_list(Results(i)).name
    im = imread(imName);
    im = imresize(im, [100 100]);
     if (ndims(im)~=3)
         I2(:, :, 1, i) = im;
         I2(:, :, 2, i) = im;
         I2(:, :, 3, i) = im;
     else
         I2(:, :, :, i) = im;
     end
end
figure('color',[1,1,1]);
montage(I2(:, :, :, (1:i-1)));

title(['CVCOT result for ',imName1])
I3 = uint8(zeros(100, 100, 3, NumShow))
for i=1:NumShow
    imName=image_list(Results1(i)).name
    im1 = imread(imName);
    im1 = imresize(im1, [100 100]);
     if (ndims(im)~=3)
         I3(:, :, 1, i) = im1;
         I3(:, :, 2, i) = im1;
         I3(:, :, 3, i) = im1;
     else
         I3(:, :, :, i) = im1;
     end
end
figure('color',[1,1,1]);
montage(I3(:, :, :, (1:i-1)));
title(['result for ',imName1])
figure()
title(['Query Image',imName1])
imName1=image_list(item).name
img=imread(imName1)
imshow(img)