%-------------------
% postprocessing.m
%-------------------
tt = length(t);

% set solution in matrix form
for it = 1:tt
    yy = y(it,:);
    
    S(:,:,it) = reshape(yy(:,1:n^2), [n,n]);
    A(:,:,it) = reshape(yy(:,n^2+1:2*n^2), [n,n]);
    I(:,:,it) = reshape(yy(:,2*n^2+1:3*n^2), [n,n]);
    R(:,:,it) = reshape(yy(:,3*n^2+1:4*n^2), [n,n]);
    D(:,:,it) = reshape(yy(:,4*n^2+1:5*n^2), [n,n]);
end

% compute the solution by region
Sreg = zeros(n,tt);
Areg = zeros(n,tt);
Ireg = zeros(n,tt);
Rreg = zeros(n,tt);
Dreg = zeros(n,tt);
for i = 1:n   
    for it=1:tt
        Sreg(i,it) = sum(S(i,:,it));
        Areg(i,it) = sum(A(i,:,it));
        Ireg(i,it) = sum(I(i,:,it));
        Rreg(i,it) = sum(R(i,:,it));
        Dreg(i,it) = sum(D(i,:,it));
    end
end

%  newcases calculation


% IFR Calculation        
%  IFR calculation

Nstar = zeros(n,1); 

for it=1:tt
    for i=1:n
    Nstar(i,it) = sum(S(:,i,it)) + sum(A(:,i,it)) + sum(I(:,i,it)) + sum(R(:,i,it));
    end
end
tau = zeros(n,tt);
newA = zeros(n+1,Tend-1);
newI = zeros(n+1,Tend-1);
newD = zeros(n+1,Tend-1);
ifr = zeros(n+1,Tend-1);


for i=1:n
    for it=1:tt
        bSAI = 0;
        for k=1:n
        	for j=1:n
                bSAI = bSAI + kappaa(k) * betai * S(i,k,it) * A(j,k,it)/Nstar(k,it) + kappai(k) * betai * S(i,k,it) * I(j,k,it)/Nstar(k,it);
            end
        end
    tau(i,it) = bSAI;
    
    end
end



for i = 1:n
    for j = 1:Tend-1
        x = [j j+1];
        newA(i,j) = eta*trapz(x,tau(i,j:j+1));
        newI(i,j) = (1-eta)*trapz(x,tau(i,j:j+1)); 
        newD(i,j) = mu*trapz(x,Ireg(i,j:j+1));
        ifr(i,j) = sum(newD(i,1:j))/(sum(newA(i,1:j))+sum(newI(i,1:j)));
        
    end
end
for j = 1:Tend-1
    newA(n+1,j) = sum(newA(1:3,j));
    newI(n+1,j) = sum(newI(1:3,j));
    newD(n+1,j) = sum(newD(1:3,j));
    ifr(n+1,j) = sum(newD(n+1,1:j))/(sum(newA(n+1,1:j))+sum(newI(n+1,1:j)));
end
ifr(:,end)
