function [MI,NMI] = NormMutualInfo( A, B )
A = mat2gray(A);
B = mat2gray(B);
method =2;
A = round(255*A)+1;
B = round(255*B)+1;
im_size = numel(A);
A = reshape(A,1,im_size);
B = reshape(B,1,im_size);
switch method
    case 1
    % 参考http://www.cnblogs.com/ziqiao/archive/2011/12/13/2286273.html#3350670
        if length( A ) ~= length( B)
            error('length( A ) must == length( B)');
        end
        total = length(A);
        A_ids = unique(A);
        B_ids = unique(B);

        % Mutual information
        MI = 0;
        for idA = A_ids
            for idB = B_ids
                idAOccur = find( A == idA );
                idBOccur = find( B == idB );
                idABOccur = intersect(idAOccur,idBOccur);

                px = length(idAOccur)/total;
                py = length(idBOccur)/total;
                pxy = length(idABOccur)/total;

                MI = MI + pxy*log2(pxy/(px*py)+eps); % eps : the smallest positive number

            end
        end

        % Normalized Mutual information
        Hx = 0; % Entropies
        for idA = A_ids
            idAOccurCount = length( find( A == idA ) );
            Hx = Hx - (idAOccurCount/total) * log2(idAOccurCount/total + eps);
        end
        Hy = 0; % Entropies
        for idB = B_ids
            idBOccurCount = length( find( B == idB ) );
            Hy = Hy - (idBOccurCount/total) * log2(idBOccurCount/total + eps);
        end

        NMI = 2 * MI / (Hx+Hy);

case 2
    % 使用accumarray方法 
    A=A(:);
    B=B(:);
    if length(A)~=length(B)
        error('A B must be the SAME length!\n');
    end
    H=accumarray([A B],ones(1,size(A,1)));
    Pab=H/length(A);
    pa=sum(Pab,2);
    pb=sum(Pab,1);
    Pa=repmat(pa,1,size(Pab,2));
    Pb=repmat(pb,size(Pab,1),1);
    MI=sum(sum(Pab.*log2((Pab+eps)./(Pa.*Pb+eps)+eps)));
    Ha=-sum(pa.*log2(pa+eps));% 熵
    Hb=-sum(pb.*log2(pb+eps));
    NMI=2*MI/(Ha+Hb);
end

end

