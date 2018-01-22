% v_{nt} = \sum_{i=1}^{W}\sum_{j=1}^{H}\sum_{t'=1}^{t-1}y_{ijnt'} \\ \nonumber n=1,\cdots,N; t=1,\cdots,T
% Relation between outside configuration and moving variables:

function model = gera_restricao_7(model,N,H,W,T,mapObj_y,v,nvar)

nr = N*(T-1);
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

lhs = zeros(nr,1);
for n=1:N
   for t=2:T
      w = w +1;
      rest_name(w) = {strcat('rest7_',int2str(n),'_',int2str(t)) };
      
      %add v constants
      lhs(w) = v(n,t);
      
      %add b coeficientes
      
      for i=1:W         
          for j=1:H
              for tt=1:t-1
                  A1(w,mapObj_y(strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(tt))))=1;
              end
          end
          
      end
       
   end
    
end

rest_name = char(rest_name);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end