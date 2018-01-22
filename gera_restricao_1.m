% \sum_{i = 1}^{W} \sum_{j = 1}^{H} b_{ijnt} + v_{nt} =1,  \\ \nonumber  n=1,\cdots N;~~t=1,\cdots,T

%In each time period, each block must either be within the stack or in the outside region:

function model = gera_restricao_1(model,N,H,W,T,mapObj_b,v,nvar)

nr = N*T;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

lhs = zeros(nr,1);
for n=1:N
   for t=1:T
      w = w +1;
      rest_name(w) = {strcat('rest1_',int2str(n),'_',int2str(t)) };
      
      %add v constants
      lhs(w) = 1 - v(n,t);
      
      %add b coeficientes
      
      for i=1:W
         
          for j=1:H
             
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))=1;
          end
          
      end
       
   end
    
end

rest_name = char(rest_name);


rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end