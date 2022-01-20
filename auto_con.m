function result = auto_con(im)
min_va = min(im(:));
max_va = max(im(:));
result = (im-min_va)/(max_va-min_va);
end