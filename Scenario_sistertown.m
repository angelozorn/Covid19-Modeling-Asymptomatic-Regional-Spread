%--------------------------
% Scenario_Sistertown.m
% case of 3 regions (n=3)
%--------------------------

% ------- first order parameters (nx1)    
sig   = [0.5; 4; 4];  % rate of trips outside the region  
%kappaa = [7 7 7; 7 20 20; 7 20 20]; %average number of contacts  for asymptomatic within the region
%kappai = [7 7 7; 7 7 7; 7 20 20];  % average number of contacts  for infected within the region

% ------- second order parameters (nxn) 
nu      = [0 0.5 0.5; ... % trip distributions among regions
           0.3 0 0.7; ... % IMPORTANT: row-wise sum =1!
           0.3 0.7 0];
rho     = [0.  10.    10.; ... % return rates from trips among regions
           2.  0     2.; ... % IMPORTANT: the diagonal terms must be 0
           2.  2.    0.];
       

       
