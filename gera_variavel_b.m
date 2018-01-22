

function [model,mapObj_b,nvar] = gera_variavel_b(model,N,H,W,T,nvar)

nb = (W*H*N*T);
colnames = cell(1,nb);
w =0;
for i = 1:W 
    for j = 1:H
         for n = 1: N
              for t = 1:T
                    w = w +1;
                    colnames(w) = {strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t)) };
              end
         end
    end
end

pos = linspace(nvar+1,nvar+nb,nb);
nvar=nvar+nb;
mapObj_b = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(nb,1);
lb = sparse(nb,1);
ub = ones(nb,1);
ctypes = char (ones ([1, nb]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end