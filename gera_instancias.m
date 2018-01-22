
% m = input('N�mero de linhas do p�tio = ');
% n = input('N�mero de colunas do p�tio = ');
% q = input('Quantidade de cont�ineres = ');
% X = input('N�mero de navios = ');
% NP = input('N�mero de portos percorridos = ');
% m=6;
% n=267;
% q=1500;
% X=6;

function [P] = gera_instancias(m,n,q)

    if m*n<q
        cont_max=m*n;
        error ('N�mero de cont�ineres excedidos. Coloque menos do que %d',cont_max);


    else
    cont = 1:q;
    patio=zeros(m,n);
    x=1;
    % b=numel(patio); %n�mero de elementos que v�o para o navio i

    % [row,col]=find(patio==0);
    % posicoes=[row,col];
    i=0;

    while i~=1
        j=datasample(cont,1);
        k=randi(m);
        l=randi(n);
        X=patio(k,l);
            if X==0
               patio(k,l)=j;
               e=find(cont==j);
               cont(e)=[]; %removendo o elemento que j� foi posto.
            end
        i=isempty(cont);   
    end

    nn=m-1;
    condicao=m;
    while x ~= condicao  
        for ii=(1:nn)
            for jj=1:n
                lin=ii+1;          
                if patio(lin,jj)==0
                   patio(lin,jj)=patio(ii,jj);  
                   patio(ii,jj)=0;
                end
            end
        end
          x=x+1;
    end  

    end  
P=patio;
%save('instanciaTESTE1.mat','P');
%spy(patio)
end