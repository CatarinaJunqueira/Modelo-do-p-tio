% The LIFO policy has to be ensured now that we are handling more than one relocation
% per time period. If in period t, block n is below block q and block n is moved, then
% in period t +1 block n cannot be found below block q. Consequently, the following
% logical implication must be enforced (for each period t =1... ,N - 1).

function model = gera_restricao_8(model,N,H,W,mapObj_x,nvar)

nr = ((W*H)^2)*(N-1);
A1 = sparse(nr,nvar);
M=N*(H^2);
rest_name = cell(1,nr);
w=0;
for i=1:W
    for k=1:W
       for j=1:H
           for l=1:H
               for t=1:N-1
                  w = w +1;
                  rest_name(w) = {strcat('rest8_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(t)) };

                  for n=1:N
                      %\sum_{n=1}^{N}x_{i,j,k,l,n,t}
                       A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))= M;
                       
                       for jj=j+1:H
                           for ll=l+1:H
                              %\sum_{n=1}^{N}\sum_{j'=j+1}^{H}\sum_{l'=l+1}^{H}x_{i,j',k,l',n,t}
                              A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(jj),'_',int2str(k),'_',int2str(ll),'_',int2str(n),'_',int2str(t))))=1; 
                           end
                       end         
                  end
               end                
           end
       end         
    end   
end

rest_name = char(rest_name);

lhs = -inf(nr,1);
rhs = M*ones(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end