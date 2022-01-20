function [NMI]=nmi(img1,img2)
img1 = round(255*img1);
img2 = round(255*img2);
%计算归一化互信息
        [Ma,Na] = size(img1);
        [Mb,Nb] = size(img2);
        m=min(Ma,Mb);
        n=min(Na,Nb); 
        ET=entropy(img1);
        ES=entropy(img2);%//模板熵
        histq=zeros(256,256);%//联合直方图，清空
        %//联合直方图
        for s=1:m
            for t=1:n
                x=img1(s,t)+1;y=img2(s,t)+1;%//灰度<—>坐标
                histq(x,y)=histq(x,y)+1;
            end
        end
        p=histq./sum(sum(histq));%//联合概率密度
        EST=-sum(sum(p.*log(p+eps)));
        NMI=(ES+ET)/EST;%可以改成互信息或者归一化系数等等
