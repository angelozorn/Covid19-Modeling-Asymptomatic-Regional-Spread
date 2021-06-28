%plot.m
reg = zeros(n,n,n);
regipeak = zeros(n,n);
regapeak = zeros(n,n);
regdtot = zeros(n,n);


for i=1:n
    regipeak(1,i) = max(Ireg1(i,:));
    regapeak(1,i) = max(Areg1(i,:));
    regdtot(1,i) = Dreg1(i,end);
    regipeak(2,i) = max(Ireg2(i,:));
    regapeak(2,i) = max(Areg2(i,:));
    regdtot(2,i) = Dreg2(i,end);
    regipeak(3,i) = max(Ireg3(i,:));
    regapeak(3,i) = max(Areg3(i,:));
    regdtot(3,i) = Dreg3(i,end);
end


w = categorical({'model 1','model 2','model 3'});
w = reordercats(w,{'model 1','model 2','model 3'});

for i = 1:n
    reg(:,:,i) = [regipeak(1,i) regapeak(1,i) regdtot(1,i);regipeak(2,i) regapeak(2,i) regdtot(2,i);regipeak(3,i) regapeak(3,i) regdtot(3,i)]; 
end

figure;
bar(w,reg(:,:,1))
legend('peak infected','peak asymptomatic','total Death','Position',[0.2 0.85 0.15 0.085])
title('Region 1')
figure;
bar(w,reg(:,:,2))
legend('peak infected','peak asymptomatic','total Death','Position',[0.2 0.85 0.15 0.085])
title('Region 2')
figure;
bar(w,reg(:,:,3))
legend('region 1 peak infected','region 1 peak asymptomatic','region 1 total Death','Position',[0.2 0.85 0.15 0.0885])
title('Region 3')
    

