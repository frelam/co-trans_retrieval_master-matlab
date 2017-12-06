I=imread('D:/1.png');
imshow(I);
%I1=rgb2gray(I);
[height,width]=size(I);
 for (i=0;i<height;i++)
     {
 for(j=0;j<width;j++)
 {
     n[s[i][j]]++;
     }
     }
     for(i=0;i<L;i++)
         {
         p[i] = n[i]/(width*height);
         }
         for(i=0;i<L;i++)
            { for(j=0;j<i;j++)
                {
                    c[i]+=p[j];
                }
                }
                max=min=s[0][0];
                for(i=0;i<height;i++){
                   for(j=0;j<width;j++){
                       if(max<s[i][j])
                           {
                           max=s[i][j];
                           }
                       else if(min>s[i][j]
                               {
                                   min=s[i][j];
                                   }
                               }
                               }
                            for(i=0;i<height;i++)
                                {
                   for(j=0;j<width;j++)
                   {
                       t[i][j]=c[s[i][j]*(max-min)+min;
                           }
                       }
                       