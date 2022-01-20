function [NMI]=nmi(img1,img2)
img1 = round(255*img1);
img2 = round(255*img2);
%�����һ������Ϣ
        [Ma,Na] = size(img1);
        [Mb,Nb] = size(img2);
        m=min(Ma,Mb);
        n=min(Na,Nb); 
        ET=entropy(img1);
        ES=entropy(img2);%//ģ����
        histq=zeros(256,256);%//����ֱ��ͼ�����
        %//����ֱ��ͼ
        for s=1:m
            for t=1:n
                x=img1(s,t)+1;y=img2(s,t)+1;%//�Ҷ�<��>����
                histq(x,y)=histq(x,y)+1;
            end
        end
        p=histq./sum(sum(histq));%//���ϸ����ܶ�
        EST=-sum(sum(p.*log(p+eps)));
        NMI=(ES+ET)/EST;%���Ըĳɻ���Ϣ���߹�һ��ϵ���ȵ�
