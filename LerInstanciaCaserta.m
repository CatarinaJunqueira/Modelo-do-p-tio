
function [P] = LerInstanciaCaserta()
P=csvread('data3-4-1.dat');

P(:,1)=[];
P(1,:)=[];

b = zeros(2,size(P,2)); 
k = 0; %row position, can be 0,1,2 or 3 in this case
P = [P(1:k,:); b; P(k+1:end,:)];
end