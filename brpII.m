function  [nmov,Pt] = brpII(P)

N = nnz(P);

H = size(P,1);

W = size(P,2);

T=N;

model = Cplex('brpII');
model.Model.sense = 'minimize';

nvar = 0; 
nv = (N*T);
v = triu(ones(nv,nv),1);

[model,mapObj_x,nvar] = gera_variavel_x(model,N,H,W,T,nvar);

%[model,mapObj_x,nvar] = gera_variavel_x_cost(model,N,H,W,T,nvar);

nx=nvar;

[model,mapObj_y,nvar] = gera_variavel_y(model,N,H,W,T,nvar);

[model,mapObj_b,nvar] = gera_variavel_b(model,N,H,W,T,nvar);

model = gera_restricao_0(model,N,H,W,mapObj_b,nvar,P);

model = gera_restricao_1(model,N,H,W,T,mapObj_b,v,nvar);

model = gera_restricao_2(model,N,H,W,T,mapObj_b,nvar);

model = gera_restricao_3(model,N,H,W,T,mapObj_b,nvar);

model = gera_restricao_6(model,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar);

model = gera_restricao_7(model,N,H,W,T,mapObj_y,v,nvar);

model = gera_restricao_8(model,N,H,W,mapObj_x,nvar);

model = gera_restricao_9(model,N,H,W,mapObj_x,mapObj_b,nvar);

model = gera_restricao_10(model,N,H,W,mapObj_x,nvar);

model = gera_restricao_A(model,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar);

fprintf('Modelo brep-II criado\n');
%model.writeModel('model.lp');
%model.Param.mip.strategy.search.Cur=4;
model.solve();

% Display solution
fprintf ('\nSolution status = %s\n',model.Solution.statusstring);
fprintf ('Valor da Funcao Objetivo: %f\n', model.Solution.objval);
fprintf ('Numero de remanejamentos: %f\n', sum(model.Solution.x(1:nx)));

Pt = obterP(model,mapObj_b,H,W,N,T);
nmov=model.Solution.objval;


