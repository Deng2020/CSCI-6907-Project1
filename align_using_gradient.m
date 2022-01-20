function [ima] = align_using_gradient(ima,imb)
[m,n] = size(ima);
hori_gra  = [zeros(1,n);ima(2:end,:)-ima(1:end-1,:)];
ver_gra  = [zeros(m,1),ima(:,2:end)-ima(:,1:end-1)];
ima_gra = sqrt(hori_gra.^2+ver_gra.^2);
hori_gra  = [zeros(1,n);imb(2:end,:)-imb(1:end-1,:)];
ver_gra  = [zeros(m,1),imb(:,2:end)-imb(:,1:end-1)];
imb_gra = sqrt(hori_gra.^2+ver_gra.^2);

[row_shift,col_shift] = get_align(ima_gra,imb_gra);

if row_shift>=0
    ima = [zeros(row_shift,n);ima(1:m-row_shift,:)];
else
    ima = [ima(-row_shift+1:m,:);zeros(abs(row_shift),n)];
end
if col_shift>=0
    ima = [zeros(m,col_shift),ima(:,1:n-col_shift)];
else
    ima = [ima(:,-col_shift+1:n),zeros(m,abs(col_shift))];
end


end