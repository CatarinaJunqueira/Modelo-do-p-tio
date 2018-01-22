function Pt = obterP(model,mapObj_b,H,W,N,T)

Pt = cell(1,T);

for t=1:T
    Pt{t}=zeros(H,W);
    for i=1:W
        for j=1:H
            for n=1:N
                if model.Solution.x(mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))==1
                   Pt{t}(H-j+1,i)=n; 
                end                
            end            
        end        
    end    
end
end