% \sum_{n = 1}^{N}b_{ijnt} \leq 1,

% In each time period, each slot (i, j) must be occupied by at most one block:

function model = gera_restricao_2(model,N,H,W,T,mapObj_b,nvar)

nr = W*H*T;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
for i=1:W
   for j=1:H
       for t=1:T
          w = w +1;
          rest_name(w) = {strcat('rest2_',int2str(i),'_',int2str(j),'_',int2str(t)) };

          for n=1:N             
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))=1;          
          end
       end       
   end    
end

rest_name = char(rest_name);

lhs = -inf(nr,1);
rhs = ones(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end