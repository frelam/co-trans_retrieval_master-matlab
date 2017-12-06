clc;
close all;

vocab = csvread('Centers_All_Inv.csv');
centers = vocab';

testimgPath1 = dir('F:\test for HOG image retrieval\Dataset\All Train\*.jpg');
hstgrm = [];
fullset_image_ftr = [];
vocab_size = 7000;


for num = 1:length(testimgPath1)
    file_name = testimgPath1(num).name;
    out(num,:) = [cellstr(file_name) num2cell(num)];
    
    full_file_name = fullfile('F:\test for HOG image retrieval\Dataset\All Train',file_name);
    
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
    D=vl_alldist2(single(vocab'),single(features'),'chi2');
    [~,I] = min(D);
    hist_map=hist(I,map);
    
    %normalize with L1 norm of histogram
    hist_map=hist_map/size(features,2);
    [val,index] = max(hist_map);
    hist_map = hist_map';
    Y1 = circshift(hist_map,length(hist_map)-index+1);
    hist_map1 = Y1';
    image_hist(num,:) = hist_map1;

end