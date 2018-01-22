
% Flow balancing constraint’’: a relation between configura- tion variables 
% and movement variables must be enforced

function model = gera_restricao_6(model,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar)

nr = W*H*N*(T-1);
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for i=1:W
    for j=1:H
       for n=1:N
           for t=2:T
               w = w +1;
               rest_name(w) = {strcat('rest6_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t)) };
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))= 1; % b_{i,j,n,t}
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1))))= -1; % -b_{i,j,n,t-1}
               A1(w,mapObj_y(strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1))))= 1; % y_{i,j,n,t-1}
                
                for k=1:W
                    for l=1:H
                        %\sum_{k=1}^{W}\sum_{l=1}^{H}x_{k,l,i,j,n,t-1}
                        A1(w,mapObj_x(strcat('x_',int2str(k),'_',int2str(l),'_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1))))=A1(w,mapObj_x(strcat('x_',int2str(k),'_',int2str(l),'_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1)))) -1;
                        %\sum_{k=1}^{W}\sum_{l=1}^{H}x_{i,j,k,l,n,t-1}
                        A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t-1))))=A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t-1))))+ 1;                        
                    end
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