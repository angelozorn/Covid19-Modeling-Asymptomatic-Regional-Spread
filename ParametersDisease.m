

       
%--------------------------
% ParametersDisease.m
% case of 3 regions (n=3)
%--------------------------

zeta = 17.4; % days
delta = 0.01; %the probability of dying when infected and symptomatic
gama   = (1-delta)/zeta;% recovery rate of asymptomatic
gami   = (1-delta)/zeta; % recovery rate of symptomatic
betai   = 0.06;% proportion of contacts between S and I that lead to infection
betaa   = 0.75*betai; %proportion of contacts between S and A that lead to infection
eta = 0.4; %percentage of infections that are asymptomatic 
mu = delta/zeta; % death rate of symptomatic cases

 

       
