%ensures that only blocks above the block to be retrieved can be moved.

function model = gera_restricao_9(model,N,H,W,mapObj_x,mapObj_b,nvar)
M=(H^2)*(W^2)*N+1;
nr = W*N;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for i=1:W
    for t=1:N
      w = w +1;
      rest_name(w) = {strcat('rest9_',int2str(i),'_',int2str(t))};
          for j=1:H
              for k=1:W
                  for l=1:H
                      for n=1:N
                          for ii=1:i-1
                             %\sum_{j=1}^{H}\sum_{k=1}^{W}\sum_{l=1}^{H}\sum_{n=1}^{N}\sum_{i'=1}^{i-1}x_{i',j,k,l,n,t}
                             A1(w,mapObj_x(strcat('x_',int2str(ii),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))= 1;
                          end

                          for iii=i+1:W
                              %\sum_{j=1}^{H}\sum_{k=1}^{W}\sum_{l=1}^{H}\sum_{n=1}^{N}\sum_{i''=i+1}^{W}x_{i'',j,k,l,n,t}
                              A1(w,mapObj_x(strcat('x_',int2str(iii),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))= 1;                          
                          end                                           
                      end 
                  end
              end
              
              
              A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(t),'_',int2str(t))))= M;
          end 
          

    end   
end

rest_name = char(rest_name);

lhs = -inf(nr,1);

rhs = M*ones(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end