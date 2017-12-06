clc;
close all;
clear;

%% Training
tic;
testimgPath1 = dir('H:\朱慧敏算法 co-training\test for HOG image retrieval\Image-Retrieval-master\Dataset\All Train\*.jpg');
hstgrm = [];
fullset_image_ftr = [];

for num = 1:length(testimgPath1)
    file_name = testimgPath1(num).name;
    out(num,:) = [cellstr(file_name) num2cell(num)];
    
    full_file_name = fullfile('H:\朱慧敏算法 co-training\test for HOG image retrieval\Image-Retrieval-master\Dataset\All Train',file_name);
%     full_file_name1 = fullfile('/home/divya/Documents/Year3Sem1/DIP/Project/test1/hog',file_name);
    
    im = imread(full_file_name);
    im1 = rgb2gray(im);
    im1 = imresize(im1, 0.25, 'bilinear');
    edg1 = edge(im1,'Canny');
    edg = padarray(edg1,[100,100],'both');
    edg = im2single(edg);

    [row,col] = find(edg==1);
    indices = [row, col];
    siz = size(indices,1);
    
    cellSize = 3;
    image_ftr = [];
    for i = 1 : siz
        
        temp_ind = indices(i,:);
        rect = [temp_ind(1,1) - 4, temp_ind(1,2) - 4, 8 , 8];
        patch = imcrop(edg,rect);

        hog = vl_hog(patch, cellSize, 'verbose', 'variant', 'dalaltriggs', 'numOrientations', 9) ;
        l = 1;
        
        point_ftr = [];
        for j = 1 : size(hog,1)
            for k = 1 : size(hog,2)
                ftr(l,:) = hog(j,k,:);
                point_ftr = [point_ftr,ftr(l,:)];
                l = l+1;
            end
        end
        image_ftr = [image_ftr;point_ftr];
        
    end
    fullset_image_ftr = [fullset_image_ftr;image_ftr];
   
end

var = 0;
few_fullset_image_ftr = [];
while var < (size(fullset_image_ftr,1) - 8)
     few_fullset_image_ftr = [few_fullset_image_ftr;fullset_image_ftr((var + 8),:)];
    var = var + 8;
end

vocab_size = 1000;

% randorder = randperm(size(fullset_image_ftr,1))';
% rand_fullset_image_ftr = fullset_image_ftr(randorder,:);
% few_fullset_image_ftr = rand_fullset_image_ftr(1:5000,:);

%Cluster the Features into vocab_size number of clusters
[centers, assignments] = vl_kmeans(single(few_fullset_image_ftr'), vocab_size);
vocab=centers';
xlswrite('Centers_All_Inv.xlsx',vocab);

for num = 1:length(testimgPath1)
    file_name = testimgPath1(num).name;
    out(num,:) = [cellstr(file_name) num2cell(num)];
    
    full_file_name = fullfile('H:\朱慧敏算法 co-training\test for HOG image retrieval\Image-Retrieval-master\Dataset\All Train',file_name);
    
    im = imread(full_file_name);
    im1 = rgb2gray(im);
    im1 = imresize(im1, 0.25, 'bilinear');
    clear edg1;
    edg1 = edge(im1,'Canny');
    edg = padarray(edg1,[100,100],'both');
    edg = im2single(edg);

    [row,col] = find(edg==1);
    indices = [row, col];
    siz = size(indices,1);
    
    cellSize = 3;
    image_ftr = [];
    for i = 1 : siz
        
        temp_ind = indices(i,:);
        rect = [temp_ind(1,1) - 4, temp_ind(1,2) - 4, 8 , 8];
        patch = imcrop(edg,rect);

        hog = vl_hog(patch, cellSize, 'verbose', 'variant', 'dalaltriggs', 'numOrientations', 9) ;
        l = 1;
        
        point_ftr = [];
        for j = 1 : size(hog,1)
            for k = 1 : size(hog,2)
                ftr(l,:) = hog(j,k,:);
                point_ftr = [point_ftr, ftr(l,:)];
                l = l+1;
            end
        end
        image_ftr = [image_ftr; point_ftr];
        
    end
    features = image_ftr;
    vocab_bins = vocab_size;
    
    %Create a histogram map depending on number of features
    map=linspace(1,vocab_bins,vocab_bins);
    D=vl_alldist2(vocab',single(features'),'chi2');
    [~,I] = min(D);
    hist_map=hist(I,map);
    
    %normalize with L1 norm of histogram
    hist_map=hist_map/size(features,2);
    [val,index] = max(hist_map);
    hist_map = hist_map';
    Y1 = circshift(hist_map,length(hist_map)-index+1);
    hist_map1 = Y1';
    image_hist(num,:) = hist_map1;
    
    %image=imread(char(image_paths(i)));
    
    %dense sample Sift Features and calculate closest cluster
    %[frames,features]=vl_dsift(single(image),'step',8,'size',[8 8],'fast');

end


% [IDX, C] = kmeans(fullset_image_ftr, 200, 'MaxIter', 500, 'EmptyAction', 'drop');
% hstgrm(num,:) = hist(IDX,200);

xlswrite('Train_All_Inv.xlsx',image_hist);
