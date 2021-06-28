function dydt = DE(t,y,kappaa,kappai)

global n nn

S = reshape(y(1:n^2,:), [n,n]);
A = reshape(y(n^2+1:2*n^2,:), [n,n]);
I = reshape(y(2*n^2+1:3*n^2,:), [n,n]);
R = reshape(y(3*n^2+1:4*n^2,:), [n,n]);
D = reshape(y(4*n^2+1:5*n^2,:), [n,n]);
ParametersDisease;

Scenario_sistertown
%Scenario_centralmarketplace

dSdt = zeros(n,n);
dAdt = zeros(n,n);
dIdt = zeros(n,n);
dRdt = zeros(n,n);
dDdt = zeros(n,n);


Nstar = zeros(n,1);
for i=1:n
    
    Nstar(i,1) = sum(S(:,i)) + sum(A(:,i)) + sum(I(:,i)) + sum(R(:,i));
    
end


for i=1:n
  
    sk = 0; ak = 0; ik = 0; rk = 0;
    for k=1:n
        sk   = sk + rho(i,k) * S(i,k);
        ak   = ak + rho(i,k) * A(i,k);
        ik   = ik + rho(i,k) * I(i,k);
        rk   = rk + rho(i,k) * R(i,k);
        
    end
    
    bSIj = 0;
    bSAj = 0;
    for j=1:n
        bSIj = bSIj + kappai(i) * betai * S(i,i) * I(j,i)/Nstar(i);
        bSAj = bSAj + kappaa(i) * betaa * S(i,i) * A(j,i)/Nstar(i);
        
    end 
    tauii = bSIj + bSAj;
    
    dSdt(i,i) = sk - sig(i)*S(i,i) - tauii;
    dAdt(i,i) = ak - sig(i)*A(i,i) + eta*tauii - gama*A(i,i);
    dIdt(i,i) = ik - sig(i)*I(i,i) + (1-eta)*tauii - gama*I(i,i) - mu * I(i,i);
    dRdt(i,i) = rk - sig(i)*R(i,i) + gami * I(i,i) + gama*A(i,i) ;
    dDdt(i,i) = mu*I(i,i);
end

for i=1:n
    for k=1:n
    if k~= i
    bSIj = 0;
    bSAj = 0;
    for j=1:n
        bSIj = bSIj + kappai(k) * betai * S(i,k) * I(j,k)/Nstar(k);
        bSAj = bSAj + kappaa(k) * betaa * S(i,k) * A(j,k)/Nstar(k);
    end
    tauik = bSIj + bSAj; 
    
    dSdt(i,k) = sig(i)*nu(i,k)*S(i,i) - rho(i,k)*S(i,k) - tauik;
    dAdt(i,k) = sig(i)*nu(i,k)*A(i,i) - rho(i,k)*A(i,k) + eta*tauik -gama*A(i,k);
    dIdt(i,k) = sig(i)*nu(i,k)*I(i,i) - rho(i,k)*I(i,k) + (1-eta)*tauik - mu*I(i,k) - gami*I(i,k);
    dRdt(i,k) = sig(i)*nu(i,k)*R(i,i) - rho(i,k)*R(i,k) + gami * I(i,k) + gama*A(i,k);
    dDdt(i,k) = mu*I(i,k);
    end
    end
end

dydt = zeros(nn,1);
dydt  = [dSdt(:); dAdt(:); dIdt(:); dRdt(:); dDdt(:)];

return

