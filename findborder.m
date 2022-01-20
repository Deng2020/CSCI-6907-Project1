function colorImCd_cut = findborder(im)
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
th = 0.1;
row_start =1;
row_end = size(R,1);
col_start = 1;
col_end = size(R,2);
for m=1:size(im,1)/10
    if mean(R(m,:))<0.08||mean(B(m,:))<0.08||mean(G(m,:))<0.08||...
        std(R(m,:))<th||std(B(m,:))<th||std(G(m,:))<th||...
        (mean(R(m,:))<0.3&&mean(B(m,:))<0.3&&mean(G(m,:))<0.3)
        row_start = m;
    end
end
for n=1:size(im,2)/10
     if mean(R(:,n))<0.08||mean(B(:,n))<0.08||mean(G(:,n))<0.08||...
        std(R(:,n))<th||std(B(:,n))<th||std(G(:,n))<th||...
        (mean(R(:,n))<0.3||mean(B(:,n))<0.3||mean(G(:,n))<0.3)
      col_start = n;
    end
end
for m=size(im,1):-1:size(im,1)-size(im,1)/10
   if mean(R(m,:))<0.08||mean(B(m,:))<0.08||mean(G(m,:))<0.08||...
        std(R(m,:))<th||std(B(m,:))<th||std(G(m,:))<th||...
        (mean(R(m,:))<0.2&&mean(B(m,:))<0.2&&mean(G(m,:))<0.2)       
    row_end = m;
    end
end
for n=size(im,2):-1:size(im,2)-size(im,2)/10
   if mean(R(:,n))<0.08||mean(B(:,n))<0.08||mean(G(:,n))<0.08||...
       std(R(:,n))<th||std(B(:,n))<th||std(G(:,n))<th||...
       (mean(R(:,n))<0.2&&mean(B(:,n))<0.2&&mean(G(:,n))<0.2)    
       col_end = n;
    end
end

colorImCd_cut = im(row_start:row_end,col_start:col_end,:);
end