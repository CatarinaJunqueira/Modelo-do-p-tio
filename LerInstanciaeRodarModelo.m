a = input('Primeiro valor da instância = ');
b = input('Segundo valor da instância = ');
c = input('Terceiro valor da instância = ');

Resultados_Medios=cell(2,5);
%for i=1:5
X = sprintf('Rodada %i',i);
disp(X)
instancia=strcat('data',int2str(a),'-',int2str(b),'-',int2str(c),'.dat');
P=csvread(instancia);

P(:,1)=[];
P(1,:)=[];
P = rot90(P);
P = [zeros(2,size(P,2));P]; % adicionando duas colunas de zeros
[nmov,Pt] = brpII(P);
% Resultados_Medios{1,i}=nmov; 
% Resultados_Medios{2,i}=Pt; 
% clear P
% c=c+1;
% end
% NomeInstancia=strcat('ResultadosInstanciaModeloExato',int2str(a),'-',int2str(b),'-',int2str(c),'.mat');
% save(NomeInstancia, 'Resultados_Medios'); 