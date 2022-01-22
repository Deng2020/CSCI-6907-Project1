function [row_shift_re,col_shift_re] = get_align(ima,imb)

[m,n] = size(ima);
max_nmi=0;
row_shift_re =0;
col_shift_re =0;
if max(size(ima))<500
    for row_shift = -50:50
        for col_shift = -50:50
            if row_shift>=0
                ima_row = 1:m-row_shift;
                imb_row = row_shift+1:m;
            else
                ima_row=-row_shift+1:m;
                imb_row = 1:m+row_shift;
            end
            if col_shift>=0
                ima_col = 1:n-col_shift;
                imb_col = col_shift+1:n;
            else
               ima_col=-col_shift+1:n;
               imb_col = 1:n+col_shift;
            end
            temp = NormMutualInfo(ima(ima_row,ima_col),imb(imb_row,imb_col));
            if temp>max_nmi
                max_nmi = temp;
                row_shift_re =row_shift;
                col_shift_re =col_shift;
            end
        end
    end
else
    scale = ceil(max(size(ima))/500);
    ima_re = imresize(ima,1/scale);
    imb_re = imresize(imb,1/scale);
    [m,n] = size(ima_re);
    max_nmi = 0;
    row_shift_re_sub = 0;
    col_shift_re_sub = 0;
     for row_shift = -30:30
        for col_shift = -30:30
            if row_shift>=0
                ima_row = 1:m-row_shift;
                imb_row = row_shift+1:m;
            else
                ima_row=-row_shift+1:m;
                imb_row = 1:m+row_shift;
            end
            if col_shift>=0
                ima_col = 1:n-col_shift;
                imb_col = col_shift+1:n;
            else
               ima_col=-col_shift+1:n;
               imb_col = 1:n+col_shift;
            end
            temp = NormMutualInfo(ima_re(ima_row,ima_col),imb_re(imb_row,imb_col));
            if temp>max_nmi
                max_nmi = temp;
                row_shift_re_sub =row_shift;
                col_shift_re_sub =col_shift;
            end
        end
     end
    
     %%
     max_nmi = 0;
     for row_shift = (row_shift_re_sub-1)*scale:(row_shift_re_sub+1)*scale
         for col_shift = (col_shift_re_sub-1)*scale:(col_shift_re_sub+1)*scale
             if row_shift>=0
                 ima_row = 1:m-row_shift;
                 imb_row = row_shift+1:m;
             else
                 ima_row=-row_shift+1:m;
                 imb_row = 1:m+row_shift;
             end
             if col_shift>=0
                 ima_col = 1:n-col_shift;
                 imb_col = col_shift+1:n;
             else
                 ima_col=-col_shift+1:n;
                 imb_col = 1:n+col_shift;
             end
             temp = NormMutualInfo(ima(ima_row,ima_col),imb(imb_row,imb_col));
             if temp>max_nmi
                 max_nmi = temp;
                 row_shift_re =row_shift;
                 col_shift_re =col_shift;
             end
         end
     end
  %%   
    
end
end
