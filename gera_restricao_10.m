% no rearrangements are allowed 
% within the same stack and allows to fix W*(H^2)*N*N variables:
% x_{i,j,i,l,n,t}=0

function model = gera_restricao_10(model,N,H,W,mapObj_x,nvar)

nr = W*(H^2)*(N^2);
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;


for i=1:W
   for j=1:H
       for l=1:H
           for n=1:N
               for t=1:N
                   
                  w = w +1;
                  rest_name(w) = {strcat('rest10_','_',int2str(i),'_',int2str(j),'_',int2str(l),int2str(n),'_',int2str(t)) };

                  A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(i),'_',int2str(l),'_',int2str(n),'_',int2str(t))))=1;
                  
               end
           end
       end     
   end    
end

rest_name = char(rest_name);

lhs = zeros(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end