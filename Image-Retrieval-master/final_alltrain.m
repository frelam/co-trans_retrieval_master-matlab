C1 = csvread('Centers_All.csv');

testimgPath1 = dir('F:\test for HOG image retrieval\Dataset\query image\*.jpg');
vocab_size = 2000;

% for num = 1:length(testimgPath1)
for num = 1
    file_name = testimgPath1(num).name;
    
    full_file_name = fullfile('F:\test for HOG image retrieval\Dataset\query image',file_name);
   
    im1 = imread(full_file_name);
    figure;
    imshow(im1);
    
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
    hist_map =hist_map1/size(features,2); 

end

ds1 = csvread('Train_All.csv');

for p = 1 : size(ds1,1)
    dif1(p,:) = pdist2(hist_map, ds1(p,:), 'correlation');
%     dif2(p,:) = pdist2(hist_map(5,:), ds2(p,:), 'correlation');
    %dif3(p,:) = pdist2(hist_map(5,:), ds3(p,:), 'correlation');
    %dif4(p,:) = pdist2(hist_map(5,:), ds4(p,:), 'correlation');
    %dif5(p,:) = pdist2(hist_map(5,:), ds5(p,:), 'correlation');
%         dif1(p,:) = hcompare_KL(hist_map, ds1(p,:));
end
    
[m1, id1] = sort(mean(dif1,2),'ascend')
%[m2, id2] = sort(mean(dif2,2),'ascend');
%[m3, id3] = sort(mean(dif3,2),'ascend');
%[m4, id4] = sort(mean(dif4,2),'ascend');
%[m5, id5] = sort(mean(dif5,2),'ascend');

% m = [m1,m2,m3,m4,m5]
   
% testimgPath1 = dir('./test1/*.png');
% for o = 1 : size(m)
%     if m(o)<1
%         file_name = testimgPath1(id(o)).name;
%         full_file_name = fullfile('/home/divya/Documents/Year3Sem1/DIP/Project/test1',file_name);
%         f = imread(full_file_name);
%         figure, imshow(f)
%     end
% end

normalimgPath1 = dir('F:\test for HOG image retrieval\Dataset\All Train\*.jpg');
id = id1(1:15);
for num = 1:length(id)
    num1 = id1(num);
    file_name1 = normalimgPath1(num1).name;
    full_file_name = fullfile('F:\test for HOG image retrieval\Dataset\query image\All Train',file_name1);
    full_file_name2 = fullfile('F:\test for HOG image retrieval\Dataset\query image\All Train\output',file_name1);
    image = imread(full_file_name);
    imwrite(image,full_file_name2);
end