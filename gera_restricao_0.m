function model = gera_restricao_0(model,N,H,W,mapObj_b,nvar,P)

nr = H*W*N;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

lhs = zeros(nr,1);
for i=1:W
   for j=1:H
       for n=1:N
          w = w +1;
          rest_name(w) = {strcat('rest0_',int2str(i),'_',int2str(j),'_',int2str(n)) };

          if P(H-j+1,i) == n 
            lhs(w) = 1;
          end
          
          %add b coeficientes
           A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(1))))=1;         
       end
   end
end

rest_name = char(rest_name);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end
