clc;
clear;
close all;

%% Load Data
load EORData

InputData(466:740,:)=[];
TargetData(466:740,:)=[];
inputs=InputData';
targets=TargetData';

random_saver = 1;
S_saver = 20;
R=0.1;
MaxNeuron_saver = 31;
% while R<1.5
    nData=size(inputs,2);
    
    rand('state', 126)
    Perm=randperm(nData);
    
%     disp(['random saver: ' num2str(random_saver)])
%     random_saver = random_saver + 1;
    
%     Perm=1:nData;
    
    pTrainData=0.7;
    nTrainData=round(pTrainData*nData);
    trainInd=Perm(1:nTrainData);
    Perm(1:nTrainData)=[];
    trainInputs = inputs(:,trainInd);
    trainTargets = targets(:,trainInd);

    pTestData=1-pTrainData;
    nTestData=nData-nTrainData;
    testInd=Perm;
    Perm(1:nTestData)=[];
    testInputs = inputs(:,testInd);
    testTargets = targets(:,testInd);

    %% Create and Train RBF Network

    Goal=0;
    
    Spread=20.1;
%     disp(['Spread Saver: ' num2str(S_saver)])
%     S_saver=S_saver+0.1;
    
    MaxNeuron = 31;
%     disp(['max neuron saver: ' num2str(MaxNeuron_saver)])
%     MaxNeuron_saver = MaxNeuron_saver + 4;
    tic
    DisplatAt=5;
    net = newrb(trainInputs,trainTargets,Goal,Spread,MaxNeuron,DisplatAt);
    elapsed_time = toc;
    disp('elapsed_time')
    disp(elapsed_time)
    % Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets,outputs);
    performance = perform(net,targets,outputs);

    % Recalculate Training, Validation and Test Performance
    trainOutputs = outputs(:,trainInd);
    trainErrors = trainTargets - trainOutputs;
    trainPerformance = perform(net,trainTargets,trainOutputs);

    testOutputs = outputs(:,testInd);
    testError = testTargets-testOutputs;
    testPerformance = perform(net,testTargets,testOutputs);

    %% Get Best Model

    R111=corr(targets',outputs')^2;
    R222=corr(trainTargets',trainOutputs')^2;
    R444=corr(testTargets',testOutputs')^2;
%     disp([R111 R222 R444])
%         if R111>0.99 && R222>0.99 && R444>0.99
%             break;
%         end
% end

%% Plot Results

targetsnormal=(targets-min(targets))/(max(targets)-min(targets));
outputsnormal=(outputs-min(outputs))/(max(outputs)-min(outputs));
PlotResults(targets,outputs,targetsnormal,outputsnormal,'All Data');

trainTargetsnormal=(trainTargets-min(trainTargets))/(max(trainTargets)-min(trainTargets));
trainOutputsnormal=(trainOutputs-min(trainOutputs))/(max(trainOutputs)-min(trainOutputs));
PlotResults(trainTargets,trainOutputs,trainTargetsnormal,trainOutputsnormal,'Train Data');

testTargetsnormal=(testTargets-min(testTargets))/(max(testTargets)-min(testTargets));
testOutputsnormal=(testOutputs-min(testOutputs))/(max(testOutputs)-min(testOutputs));
PlotResults(testTargets,testOutputs,testTargetsnormal,testOutputsnormal,'Test Data');

