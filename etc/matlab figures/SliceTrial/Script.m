% Big Trial
% correspond to SliceTrial3 launcher configurration (launch ID 13)
% To run this experiment just run admm.trials.Launcher with the following
% arguments :
% local 12 fn SliceTrial sparsityA 0.5 sparsityW 0.5 nd 700 nf 50 ns 10
% slices 1,5,10 lam 1 ni 100

% Then you have the SliceTrial1, SliceTrial5, SliceTrial10 file and you can run this script

% experiment with numbers

% noise standard deviation = sqrt(0.1)

% Result
% -----------------------------------------------------------------
% PROPORTION OF POSITIVE LABELS IN SYNTHEIC DATA
%     0.1188
%
% RESULTS OF ALGORITHM
% positive success rate =
%     0.9146
%
% negative success rate =
%      1
%
% total success rate =
%     0.9899
%
% -----------------------------------------------------------------
% PROPORTION OF POSITIVE LABELS IN SYNTHEIC DATA
%     0.1188
%
% RESULTS OF ALGORITHM
% positive success rate =
%     0.8902
%
% negative success rate =
%      1
%
% total success rate =
%     0.9870
%
% -----------------------------------------------------------------
% PROPORTION OF POSITIVE LABELS IN SYNTHEIC DATA
%     0.1188
%
% RESULTS OF ALGORITHM
% positive success rate =
%     0.8049
%
% negative success rate =
%      1
%
% total success rate =
%     0.9768

%%Actual code
clear all
close all
clc

import java.util.ArrayList;

slices = [1;5;10];

lines = ArrayList();
lines.add('-');
lines.add('--');
lines.add(':');

x(1)= loadjson('../../../SliceTrial1');
x(2)= loadjson('../../../SliceTrial5');
x(3)= loadjson('../../../SliceTrial10');

figure(1)
figure(2)
figure(3)
figure(4)
figure(5)
figure(6)
figure(7)

for j=1:3

    display('-----------------------------------------------------------------')
    display('PROPORTION OF POSITIVE LABELS IN SYNTHEIC DATA');
    disp(x(j).pos);
    display('RESULTS OF ALGORITHM');
    display('positive success rate = ');
    disp(x(j).psr);
    display('negative success rate = ');
    disp(x(j).nsr);
    display('total success rate = ');
    disp(x(j).tsr);

    %loss function
    y = [x(j).iters.loss];
    figure(1)
    plot(y(y>0)/min(y(y>0)),lines.get(j-1));
    xlabel('iteration');
    ylabel('p/p*');
    title('Decrease in loss function');

    %primal residual
    r = [x(j).iters.pres];
    figure(2)
    plot(r(r>0),lines.get(j-1));
    xlabel('iteration');
    ylabel('primal residual');
    title('Primal residual evolution');

    %dual residual
    s = [x(j).iters.dres];
    figure(3)
    plot(s(s>0),lines.get(j-1));
    hold on

    %time of each iteration
    t = [x(j).iters.time];
    figure(4)
    plot(t(t>100),lines.get(j-1))
    hold on
    
    %primal epsilon evolution
    peps = [x(j).iters.peps];
    figure(5)
    plot(peps(peps>0),lines.get(j-1));
    hold on

    %dual epsilon evolution
    deps = [x(j).iters.deps];
    figure(6)
    plot(deps(deps>0),lines.get(j-1));
    hold on

    %cardinality
    card = [x(j).iters.card];
    figure(7)
    plot(card(card>0),lines.get(j-1));
    hold on

    Names = ArrayList();
    Names.add(['DecreaseLoss',num2str(slices(j))]);
    Names.add(['PrimalResidual',num2str(slices(j))]);
    Names.add(['DualResidual',num2str(slices(j))]);
    Names.add(['TimePerIteration',num2str(slices(j))]);
    Names.add(['PrimalEpsilon',num2str(slices(j))]);
    Names.add(['DualEpsilon',num2str(slices(j))]);
    Names.add(['Cardinality',num2str(slices(j))]);
    
end

Names = ArrayList();
Names.add('DecreaseLoss');
Names.add('PrimalResidual');
Names.add('DualResidual');
Names.add('TimePerIteration');
Names.add('PrimalEpsilon');
Names.add('DualEpsilon');
Names.add('Cardinality');

%loss function
figure(1)
xlabel('iteration');
ylabel('p/p*');
title('Decrease in loss function');

%primal residual
figure(2)
xlabel('iteration');
ylabel('primal residual');
title('Primal residual evolution');

%dual residual
figure(3)
xlabel('iteration');
ylabel('dual residual');
title('Dual residual evolution');

%time of each iteration
figure(4)
xlabel('iteration');
ylabel('time');
title('Time per iteration');

%primal epsilon evolution
figure(5)
xlabel('iteration');
ylabel('primal epsilon');
title('Primal epsilon evolution');

%dual epsilon evolution
figure(6)
xlabel('iteration');
ylabel('dual epsilon');
title('Dual epsilon evolution');

%cardinality
figure(7)
xlabel('iteration');
ylabel('cardinality of current estimate z');
title('Evolution of the estimate''s cardinality');

for i = 1:7
    figure(i)
    legend('slices=1','slices=5','slices=10')
    saveName = Names.get(i-1);
    saveas(gcf, saveName, 'png');
    saveas(gcf, saveName, 'fig');
end

%%Now look at results as a function nbSlices

psr = zeros(3,1);
nsr = zeros(3,1);
tsr = zeros(3,1);
for j=1:3
    psr(j)=x(j).psr;
    nsr(j)=x(j).nsr;
    tsr(j)=x(j).tsr;
end

%positive success rate
figure(8)
plot(slices,psr);
xlabel('number of slices');
ylabel('positive success rate');
title('Positive success rate and number of slices');

%negative success rate
figure(9)
plot(slices,nsr);
xlabel('number of slices');
ylabel('negative success rate');
title('Negative success rate and number of slices');

%total success rate
figure(10)
plot(slices,tsr);
xlabel('number of slices');
ylabel('total success rate');
title('Total success rate and number of slices');

Names = ArrayList();
Names.add('PosSuccNbSlices');
Names.add('NegSuccNbSlices');
Names.add('TotSuccNbSlices');

for i = 8:10
    figure(i)
    saveName = Names.get(i-8);
    saveas(gcf, saveName, 'png');
    saveas(gcf, saveName, 'fig');
end
