clear all; close all; clc;

global n nn

n   = 3;        
nn = 5*n^2;
S   = zeros(n,n);
A   = zeros(n,n);
I   = zeros(n,n);
R   = zeros(n,n);
D   = zeros(n,n);
y0  = zeros(nn,1);
y1 = zeros(nn,1);
y2 = zeros(nn,1);
y3 = zeros(nn,1);

Tend = 60;  

IC;
ParametersDisease;
Scenario_sistertown
%Scenario_centralmarketplace
y0 = [S0(:); A0(:); I0(:); R0(:); D0(:)]; % set the vector variables
kappaa = [7 7 7; 7 20 20; 7 20 20];
kappai = [7 7 7; 7 7 7; 7 20 20];

[t1,y1] = ode45(@(t,y)DE(t,y,kappaa(1,:),kappai(1,:)),linspace(0, Tend, Tend+1),y0);
[t2,y2] = ode45(@(t,y)DE(t,y,kappaa(2,:),kappai(2,:)),linspace(0, Tend, Tend+1),y0);
[t3,y3] = ode45(@(t,y)DE(t,y,kappaa(3,:),kappai(3,:)),linspace(0, Tend, Tend+1),y0);


y = y1;
t = t1;
postprocessing;
setfonts;


Ireg1 = Ireg;
Areg1 = Areg;
Dreg1 = Dreg;

clear S A I R D 

y = y2;
t = t2;
postprocessing;
setfonts;


Ireg2 = Ireg;
Areg2 = Areg;
Dreg2 = Dreg;

clear S A I R D 

y = y3;
t = t3;
postprocessing;
setfonts;


Ireg3 = Ireg;
Areg3 = Areg;
Dreg3 = Dreg;

plot;



