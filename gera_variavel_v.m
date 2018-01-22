

% v = triu(ones(nv,nv));


function [model,mapObj_v,nvar] = gera_variavel_v(model,N,T,nvar)

nv = (N*T);
colnames = cell(1,nv);
w =0;

 for n = 1: N
      for t = 1:T
            w = w +1;
            colnames(w) = {strcat('v_',int2str(n),'_',int2str(t))};
      end
 end

pos = linspace(nvar+1,nvar+nv,nv);
nvar=nvar+nv;
mapObj_v = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(nv,1);
%lb = zeros(nv,1);
%ub = ones(nv,1);
ctypes = char (ones ([1, nv]) * ('B'));

model.addCols(obj, [], [], [],ctypes,colnames);

end