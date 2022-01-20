function [ima,rowIndex,colIndex] = align(ima,imb)
[row_shift,col_shift] = get_align(ima,imb);
[m,n] = size(ima);
if row_shift>=0
    ima = [zeros(row_shift,n);ima(1:m-row_shift,:)];
    rowIndex = row_shift+1:m;
else
    ima = [ima(-row_shift+1:m,:);zeros(abs(row_shift),n)];
     rowIndex = 1:m+row_shift;
end
if col_shift>=0
    ima = [zeros(m,col_shift),ima(:,1:n-col_shift)];
    colIndex = col_shift+1:n;
else
    ima = [ima(:,-col_shift+1:n),zeros(m,abs(col_shift))];
     colIndex = 1:n+col_shift;
end



end