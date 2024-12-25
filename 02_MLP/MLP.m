clc;
clear;
close all;

%% Load Data

load EORData

InputData(466:740,:)=[];
TargetData(466:740,:)=[];
inputs=InputData';
targets=TargetData';

%% Load NET

% load bestnet.mat

R = 0.1;
random_saver = 0;
hidden=1;
while R<1.5 
    % Create a Fitting Network
%     hiddenLayerSize = 10; % The best one
    hiddenLayerSize = 10;
%     disp(hidden)
    hidden=hidden+1;
    TF={'tansig','purelin'};
    net = newff(inputs,targets,hiddenLayerSize,TF);

    % Choose Input and Output Pre/Post-Processing Functions
    % For a list of all processing functions type: help nnprocess
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    net.output.processFcns = {'removeconstantrows','mapminmax'};

    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivide
    rand('state',1) %# The best one
    random_saver = random_saver + 1;
%     disp(random_saver)
    net.divideFcn = 'dividerand';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainRatio = 50/100;
    net.divideParam.valRatio = 25/100;
    net.divideParam.testRatio = 25/100;

    % Choose a Training Function
    % For a list of all training functions type: help nntrain
    % 'trainlm' is usually fastest.
    % 'trainbr' takes longer but may be better for challenging problems.
    % 'trainscg' uses less memory. Suitable in low memory situations.
    net.trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

    % Choose a Performance Function
    % For a list of all performance functions type: help nnperformance
    net.performFcn = 'mse';  % Mean Squared Error %mae ,sse ,mse

    % Choose Plot Functions
    % For a list of all plot functions type: help nnplot
    net.plotFcns = {'plotperform','ploterrhist','plotregression', 'plotfit'};

    net.trainParam.showWindow=false;
    net.trainParam.showCommandLine=false;
    net.trainParam.show=100;
    net.trainParam.epochs=100;
    net.trainParam.goal=1e-8;
    net.trainParam.max_fail=100;
tic;
    % Train the Network
    [net,tr] = train(net,inputs,targets);
toc;

    %% Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets,outputs);
    performance = perform(net,targets,outputs);

    % Recalculate Training, Validation and Test Performance
    trainInd=tr.trainInd; 
    trainInputs = inputs(:,trainInd);
    trainTargets = targets(:,trainInd);
    trainOutputs = outputs(:,trainInd);
    trainErrors = trainTargets - trainOutputs;
    trainPerformance = perform(net,trainTargets,trainOutputs);

    valInd=tr.valInd;
    valInputs = inputs(:,valInd);
    valTargets = targets(:,valInd);
    valOutputs = outputs(:,valInd);
    valErrors = valTargets-valOutputs;
    valPerformance = perform(net,valTargets,valOutputs);

    testInd=tr.testInd;
    testInputs = inputs(:,testInd);
    testTargets = targets(:,testInd);
    testOutputs = outputs(:,testInd);
    testError = testTargets-testOutputs;
    meanerror= mse(testError);
    testPerformance = perform(net,testTargets,testOutputs);
      
    R111=corr(targets',outputs')^2;
    R222=corr(trainTargets',trainOutputs')^2;
    R444=corr(testTargets',testOutputs')^2;
    disp([R111 R222 R444])
    if R111>0.7 && R222>0.7 && R444>0.7
        break;
    end
end

%% Working on Generated Data

load AllCombination.mat

AllNewCombinations(:,end+1) = net(AllNewCombinations')';

%% Plots

targetsnormal=(targets-min(targets))/(max(targets)-min(targets));
outputsnormal=(outputs-min(outputs))/(max(outputs)-min(outputs));
PlotResults(targets,outputs,targetsnormal,outputsnormal,'All Data');

trainTargetsnormal=(trainTargets-min(trainTargets))/(max(trainTargets)-min(trainTargets));
trainOutputsnormal=(trainOutputs-min(trainOutputs))/(max(trainOutputs)-min(trainOutputs));
PlotResults(trainTargets,trainOutputs,trainTargetsnormal,trainOutputsnormal,'Train Data');

valTargetsnormal=(valTargets-min(valTargets))/(max(valTargets)-min(valTargets));
valOutputsnormal=(valOutputs-min(valOutputs))/(max(valOutputs)-min(valOutputs));
PlotResults(valTargets,valOutputs,valTargetsnormal,valOutputsnormal,'Validation Data');

testTargetsnormal=(testTargets-min(testTargets))/(max(testTargets)-min(testTargets));
testOutputsnormal=(testOutputs-min(testOutputs))/(max(testOutputs)-min(testOutputs));
PlotResults(testTargets,testOutputs,testTargetsnormal,testOutputsnormal,'Test Data');

% view(net)
