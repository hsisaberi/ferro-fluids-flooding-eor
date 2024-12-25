% function [R111,R222,R444,Targets,Outputs,TrainTargets,TrainOutputs,TestTargets,TestOutputs]=GENFIS2()
clc;
clear;
close all;
%% Load Data

load EORData

InputData(466:740,:)=[];
TargetData(466:740,:)=[];
Inputs=InputData;
Targets=TargetData;

R=0.1;
random_saver=1;
Radius_Saver=0.2;
InitialStepSize_Saver = 1;
StepSizeDecreaseRate_Saver = 0.1;
% while R<1.5
    
    nData=numel(Targets);
    
    rand('state', 2)
    Perm=randperm(nData);
    
%     disp(['random saver: ' num2str(random_saver)])
%     random_saver = random_saver + 1;

    pTrain=.7;
    nTrainData=round(pTrain*nData);
    TrainInputs=Inputs(Perm(1:nTrainData),:);
    TrainTargets=Targets(Perm(1:nTrainData),:);
    Perm(1:nTrainData)=[];
    TrainData=[TrainInputs TrainTargets];

    pTest=1-pTrain;
    nTestData=nData-nTrainData;
    TestInputs=Inputs(Perm,:);
    TestTargets=Targets(Perm,:);
    TestData=[TestInputs TestTargets];

    %% Design ANFIS

    % Option{2}='Sub. Clustering (genfis2)';
    
    %0.3
    Radius=0.3;
%     disp(['Radius Saver: ' num2str(Radius_Saver)])
%     Radius_Saver = Radius_Saver + 0.1;
    
    fis=genfis2(TrainInputs,TrainTargets,Radius);

    MaxEpoch=50;
    ErrorGoal=0;
    
    
    InitialStepSize=1;
%     disp(['InitialStepSize Saver: ' num2str(InitialStepSize_Saver)])
%     InitialStepSize_Saver = InitialStepSize_Saver + 0.01;

    StepSizeDecreaseRate=0.9;
%     disp(['StepSizeDecreaseRate Saver: ' num2str(StepSizeDecreaseRate_Saver)])
%     StepSizeDecreaseRate_Saver = StepSizeDecreaseRate_Saver + 0.1;
    
    StepSizeIncreaseRate=1.1;

    TrainOptions=[MaxEpoch ...
                  ErrorGoal ...
                  InitialStepSize ...
                  StepSizeDecreaseRate ...
                  StepSizeIncreaseRate];

    DisplayInfo=true;
    DisplayError=true;
    DisplayStepSize=true;
    DisplayFinalResult=true;
    DisplayOptions=[DisplayInfo ...
                    DisplayError ...
                    DisplayStepSize ...
                    DisplayFinalResult];

    OptimizationMethod=1;
    % 0: Backpropagation
    % 1: Hybrid
    tic
    fis=anfis([TrainInputs TrainTargets],fis,TrainOptions,[],[],OptimizationMethod);
    elapsed_time = toc;
    disp(elapsed_time)
    %% Apply ANFIS to All Data
    
    Outputs=evalfis(Inputs,fis);

    Errors=Targets-Outputs;
    MSE=mean(Errors(:).^2);
    RMSE=sqrt(MSE);
    ErrorMean=mean(Errors);
    ErrorSTD=std(Errors);

    %% Apply ANFIS to Train Data

    TrainOutputs=evalfis(TrainInputs,fis);

    TrainErrors=TrainTargets-TrainOutputs;
    TrainMSE=mean(TrainErrors(:).^2);
    TrainRMSE=sqrt(TrainMSE);
    TrainErrorMean=mean(TrainErrors);
    TrainErrorSTD=std(TrainErrors);

    %% Apply ANFIS to Test Data

    TestOutputs=evalfis(TestInputs,fis);

    TestErrors=TestTargets-TestOutputs;
    TestMSE=mean(TestErrors(:).^2);
    TestRMSE=sqrt(TestMSE);
    TestErrorMean=mean(TestErrors);
    TestErrorSTD=std(TestErrors);


%     R111=corr(Targets,Outputs)^2;
%     R222=corr(TrainTargets,TrainOutputs)^2;
%     R444=corr(TestTargets,TestOutputs)^2;
%     if R111>0.99 && R222>0.99 && R444>0.99
%         break;
%     end
% end
%% Plots

targetsnormal=(Targets-min(Targets))/(max(Targets)-min(Targets));
outputsnormal=(Outputs-min(Outputs))/(max(Outputs)-min(Outputs));
PlotResults(Targets,Outputs,targetsnormal,outputsnormal,'All Data');

TrainTargetsnormal=(TrainTargets-min(TrainTargets))/(max(TrainTargets)-min(TrainTargets));
TrainOutputsnormal=(TrainOutputs-min(TrainOutputs))/(max(TrainOutputs)-min(TrainOutputs));
PlotResults(TrainTargets,TrainOutputs,TrainTargetsnormal,TrainOutputsnormal,'Train Data');
% figure;
% plotregression(TrainTargets,TrainOutputs,'Train Data');
% set(gcf,'Toolbar','figure');


TestTargetsnormal=(TestTargets-min(TestTargets))/(max(TestTargets)-min(TestTargets));
TestOutputsnormal=(TestOutputs-min(TestOutputs))/(max(TestOutputs)-min(TestOutputs));
PlotResults(TestTargets,TestOutputs,TestTargetsnormal,TestOutputsnormal,'Test Data');
% % figure;
% % plotregression(TestTargets,TestOutputs,'Test Data');
% % set(gcf,'Toolbar','figure');



% end

%% NEW

load AllCombination.mat
% A = gpuArray(AllNewCombinations);
final_result = evalfis(AllNewCombinations, fis);
















