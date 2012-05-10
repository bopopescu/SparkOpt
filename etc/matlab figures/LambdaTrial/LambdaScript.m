% LambdaTrial
% correspond to lambdaTrial launcher configuration (launch ID 14)
% To run this experiment just run admm.trials.Launcher with the following
% arguments :
% local 14 fn LambdaTrial nd 700 nf 50 ns 5 ni 50

% Then you have the LambdaTrial's files and you can run this script

% experiment with numbers lambda = [0.001,0.01,0.1,1,10]

% noise standard deviation = sqrt(0.1)

%Results

% -----------------------------------------------------------------
% RESULTS OF ALGORITHM
% positive success rate = 
%      1
% 
% negative success rate = 
%      1
% 
% total success rate = 
%      1
% 
% -----------------------------------------------------------------
% RESULTS OF ALGORITHM
% positive success rate = 
%      1
% 
% negative success rate = 
%      1
% 
% total success rate = 
%      1
% 
% -----------------------------------------------------------------
% RESULTS OF ALGORITHM
% positive success rate = 
%      1
% 
% negative success rate = 
%      1
% 
% total success rate = 
%      1
% 
% -----------------------------------------------------------------
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
% RESULTS OF ALGORITHM
% positive success rate = 
%     0.2073
% 
% negative success rate = 
%     0.9984
% 
% total success rate = 
%     0.9043

%%Actual code
clear all
close all
clc

import java.util.ArrayList;

lambdas = [0.001;0.01;0.1;1;10];

x(1)= loadjson('../../../LambdaTrial0.001');
x(2)= loadjson('../../../LambdaTrial0.01');
x(3)= loadjson('../../../LambdaTrial0.1');
x(4)= loadjson('../../../LambdaTrial1');
x(5)= loadjson('../../../LambdaTrial10');

for j=1:5

    display('-----------------------------------------------------------------')
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
    plot(y(y>0)/min(y(y>0)));
    xlabel('iteration');
    ylabel('p/p*');
    title('Decrease in loss function');

    %primal residual
    r = [x(j).iters.pres];
    figure(2)
    plot(r(r>0));
    xlabel('iteration');
    ylabel('primal residual');
    title('Primal residual evolution');

    %dual residual
    s = [x(j).iters.dres];
    figure(3)
    plot(s(s>0));
    xlabel('iteration');
    ylabel('dual residual');
    title('Dual residual evolution');

    %time of each iteration
    t = [x(j).iters.time];
    figure(4)
    plot(t(t>100))
    xlabel('iteration');
    ylabel('time');
    title('Time per iteration');

    %primal epsilon evolution
    peps = [x(j).iters.peps];
    figure(5)
    plot(peps(peps>0));
    xlabel('iteration');
    ylabel('primal epsilon');
    title('Primal epsilon evolution');

    %dual epsilon evolution
    deps = [x(j).iters.deps];
    figure(6)
    plot(deps(deps>0));
    xlabel('iteration');
    ylabel('dual epsilon');
    title('Dual epsilon evolution');

    %cardinality
    card = [x(j).iters.card];
    figure(7)
    plot(card(card>0));
    xlabel('iteration');
    ylabel('cardinality of current estimate z');
    title('Evolution of the estimate''s cardinality');

    Names = ArrayList();
    Names.add(['DecreaseLoss',num2str(lambdas(j))]);
    Names.add(['PrimalResidual',num2str(lambdas(j))]);
    Names.add(['DualResidual',num2str(lambdas(j))]);
    Names.add(['TimePerIteration',num2str(lambdas(j))]);
    Names.add(['PrimalEpsilon',num2str(lambdas(j))]);
    Names.add(['DualEpsilon',num2str(lambdas(j))]);
    Names.add(['Cardinality',num2str(lambdas(j))]);

    for i = 1:7
        figure(i)
        saveName = Names.get(i-1);
        saveas(gcf, saveName, 'png');
        saveas(gcf, saveName, 'fig');
        close
    end
end

%%Now look at results as a function nbSlices

psr = zeros(5,1);
nsr = zeros(5,1);
tsr = zeros(5,1);
for j=1:5
    psr(j)=x(j).psr;
    nsr(j)=x(j).nsr;
    tsr(j)=x(j).tsr;
end

%positive success rate
figure(1)
plot(lambdas,psr);
xlabel('lambda');
ylabel('positive success rate');
title('Positive success rate and lambda');

%negative success rate
figure(2)
plot(lambdas,nsr);
xlabel('lambda');
ylabel('negative success rate');
title('Negative success rate and lamdba');

%total success rate
figure(3)
plot(lambdas,tsr);
xlabel('lambda');
ylabel('total success rate');
title('Total success rate and lambda');

Names = ArrayList();
Names.add('PosSuccNbSlices');
Names.add('NegSuccNbSlices');
Names.add('TotSuccNbSlices');

for i = 1:3
    figure(i)
    saveName = Names.get(i-1);
    saveas(gcf, saveName, 'png');
    saveas(gcf, saveName, 'fig');
    close
end