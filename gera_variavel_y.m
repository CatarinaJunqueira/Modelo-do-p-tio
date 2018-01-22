




function [model,mapObj_y,nvar] = gera_variavel_y(model,N,H,W,T,nvar)

ny = (W*H*N*T);
colnames = cell(1,ny);
w =0;
for i = 1:W 
    for j = 1:H
         for n = 1: N
              for t = 1:T
                    w = w +1;
                    colnames(w) = {strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t)) };
              end
         end
    end
end

pos = linspace(nvar+1,nvar+ny,ny);
nvar = nvar + ny;
mapObj_y = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(ny,1);
lb = sparse(ny,1);
ub = ones(ny,1);
ctypes = char (ones ([1, ny]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end