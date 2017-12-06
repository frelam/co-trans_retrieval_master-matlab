C1 = csvread('Centers_All_Inv.csv');

testimgPath1 = dir('F:\test for HOG image retrieval\Dataset\query image\*.jpg');
vocab_size = 7000;

% for num = 1:length(testimgPath1)
for num = 12
    file_name = testimgPath1(num).name;
    
    full_file_name = fullfile('F:\test for HOG image retrieval\Dataset\query image',file_name);
   
    im1 = imread(full_file_name);
    clear edg1;
    edg1 = edge(im1,'Canny');
%     edg1 = imcomplement(im1);
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
    
    D1=vl_alldist2(single(C1'),single(features'),'chi2');
    [~,I1] = min(D1);
    hist_map1=hist(I1,map);
    
%     % Scale Invariance
%     hist_map_cum = cumsum(hist_map1);
%     for var = 1:size(hist_map,2)
%         new_bin = (hist_map_cum(var))./(hist_map_cum(size(hist_map_cum,2)));
%         new_bin = ceil(new_bin);
%         new_hist_map(new_bin) = hist_map(var);
%     end
    
%     hist_map = new_hist_map;
    
    % Normalizing
    hist_map =hist_map1/size(features,2);
    
    [val,index] = max(hist_map);
    hist_map = hist_map';
    Y1 = circshift(hist_map,length(hist_map)-index+1);
    hist_map = Y1';
    hist_map_3(1,:) = hist_map;
    
%     % Scale Invariance
%     hist_map_cum = cumsum(hist_map);
%     for var = 1:size(hist_map,2)
%         new_bin = (hist_map_cum(var))./(hist_map_cum(size(hist_map_cum,2)));
%         new_bin = ceil(new_bin);
%         new_hist_map(new_bin) = hist_map(var);
%     end

end

for num = 12
    file_name = testimgPath1(num).name;
    
    full_file_name = fullfile('F:\test for HOG image retrieval\Dataset\query image',file_name);
   
    im1 = imread(full_file_name);
    im1 = imresize(im1,0.5,'bilinear');
    clear edg1;
    edg1 = edge(im1,'Canny');
%     edg1 = imcomplement(im1);
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
    
    D1=vl_alldist2(single(C1'),single(features'),'chi2');
    [~,I1] = min(D1);
    hist_map1=hist(I1,map);
    
%     % Scale Invariance
%     hist_map_cum = cumsum(hist_map1);
%     for var = 1:size(hist_map,2)
%         new_bin = (hist_map_cum(var))./(hist_map_cum(size(hist_map_cum,2)));
%         new_bin = ceil(new_bin);
%         new_hist_map(new_bin) = hist_map(var);
%     end
%     
%     hist_map = new_hist_map;
    
    % Normalizing
    hist_map =hist_map1/size(features,2);
    
    [val,index] = max(hist_map);
    hist_map = hist_map';
    Y1 = circshift(hist_map,length(hist_map)-index+1);
    hist_map = Y1';
    hist_map_3(2,:) = hist_map;
    
%     % Scale Invariance
%     hist_map_cum = cumsum(hist_map);
%     for var = 1:size(hist_map,2)
%         new_bin = (hist_map_cum(var))./(hist_map_cum(size(hist_map_cum,2)));
%         new_bin = ceil(new_bin);
%         new_hist_map(new_bin) = hist_map(var);
%     end

end

for num = 12
    file_name = testimgPath1(num).name;
    
    full_file_name = fullfile('F:\test for HOG image retrieval\Dataset\query image',file_name);
   
    im1 = imread(full_file_name);
    im1 = imresize(im1,0.25,'bilinear');
    clear edg1;
    edg1 = edge(im1,'Canny');
%     edg1 = imcomplement(im1);
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
    
    D1=vl_alldist2(single(C1'),single(features'),'chi2');
    [~,I1] = min(D1);
    hist_map1=hist(I1,map);
%     
%     % Scale Invariance
%     hist_map_cum = cumsum(hist_map1);
%     for var = 1:size(hist_map,2)
%         new_bin = (hist_map_cum(var))./(hist_map_cum(size(hist_map_cum,2)));
%         new_bin = ceil(new_bin);
%         new_hist_map(new_bin) = hist_map(var);
%     end
%     
%     hist_map = new_hist_map;
    
    % Normalizing
    hist_map =hist_map1/size(features,2);
    
    [val,index] = max(hist_map);
    hist_map = hist_map';
    Y1 = circshift(hist_map,length(hist_map)-index+1);
    hist_map = Y1';
    hist_map_3(3,:) = hist_map;
%     % Scale Invariance
%     hist_map_cum = cumsum(hist_map);
%     for var = 1:size(hist_map,2)
%         new_bin = (hist_map_cum(var))./(hist_map_cum(size(hist_map_cum,2)));
%         new_bin = ceil(new_bin);
%         new_hist_map(new_bin) = hist_map(var);
%     end

end



% ds1 = csvread('Train_All_Inv.csv');

ds1 = image_hist;

for p = 1 : size(ds1,1)
    dif1(p,:) = pdist2(hist_map_3(1,:), ds1(p,:), 'correlation');
%   dif1(p,:) = hcompare_KL(hist_map, ds1(p,:));
end
    
[m1, id1] = sort(mean(dif1,2),'ascend')

for p = 1 : size(ds1,1)
    dif1(p,:) = pdist2(hist_map_3(2,:), ds1(p,:), 'correlation');
%   dif1(p,:) = hcompare_KL(hist_map, ds1(p,:));
end
    
[m2, id2] = sort(mean(dif1,2),'ascend')

for p = 1 : size(ds1,1)
    dif1(p,:) = pdist2(hist_map_3(3,:), ds1(p,:), 'correlation');
%   dif1(p,:) = hcompare_KL(hist_map, ds1(p,:));
end
    
[m3, id3] = sort(mean(dif1,2),'ascend')

m = [m1,m2,m3]


% normalimgPath1 = dir('C:\Users\Jahnavi Chowdary\Desktop\IIIT\3rd Year\DIP\Project\Dataset_Small\flickr_images\images\All Train\*.jpg');
% id = id1(1:20);
% for num = 1:length(id)
%     num1 = id1(num);
%     file_name1 = normalimgPath1(num1).name;
%     full_file_name = fullfile('C:\Users\Jahnavi Chowdary\Desktop\IIIT\3rd Year\DIP\Project\Dataset_Small\flickr_images\images\All Train',file_name1);
%     full_file_name2 = fullfile('C:\Users\Jahnavi Chowdary\Desktop\IIIT\3rd Year\DIP\Project\Dataset_Small\flickr_images\images\All Train\inv_output',file_name1);
%     image = imread(full_file_name);
%     imwrite(image,full_file_name2);
% end
