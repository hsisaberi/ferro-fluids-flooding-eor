clc;
clear;
close all;

%% Load Data

load EORData
load AllCombination.mat

InputData(466:740,:)=[];
TargetData(466:740,:)=[];
inputs=InputData';
targets=TargetData';

AllNewCombinations = AllNewCombinations';
for j=1:100
    for i=1:100
        %% MLP Training

        R = 0.1;
        random_saver = 0;
        hidden=1;

        % while R<1.5 
            % Create a Fitting Network
            hiddenLayerSize = 13;
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
%             rand('state',i)
            random_saver = random_saver + 1;
            disp(['randomstate MLP1= ' num2str(i)])
            net.divideFcn = 'dividerand';  % Divide data randomly
            net.divideMode = 'sample';  % Divide up every sample
            net.divideParam.trainRatio = 70/100;
            net.divideParam.valRatio = 15/100;
            net.divideParam.testRatio = 15/100;

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
        % tic;
            % Train the Network
            [net,tr] = train(net,inputs,targets);
        % toc;

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
            disp(['MLP All Data R^2: ' num2str(R111)])
            disp(['MLP Train Data R^2: ' num2str(R222)])
            disp(['MLP Test Data R^2: ' num2str(R444)])
            disp(' ')

        %     if R111>0.99 && R222>0.99 && R444>0.99
        %         break;
        %     end
        % end

        %% All New Combination's Calculations MLP

        outputs_AllNewCombinations_MLP = net(AllNewCombinations);
%         aa1 = find(outputs_AllNewCombinations_MLP<=0);
%         outputs_AllNewCombinations_MLP(aa1) = [];
%         bb1 = find(outputs_AllNewCombinations_MLP>=100);
%         outputs_AllNewCombinations_MLP(bb1) = [];

        %% MLP's Plots

        % targetsnormal=(targets-min(targets))/(max(targets)-min(targets));
        % outputsnormal=(outputs-min(outputs))/(max(outputs)-min(outputs));
        % PlotResults(targets,outputs,targetsnormal,outputsnormal,'MLP All Data');

        % trainTargetsnormal=(trainTargets-min(trainTargets))/(max(trainTargets)-min(trainTargets));
        % trainOutputsnormal=(trainOutputs-min(trainOutputs))/(max(trainOutputs)-min(trainOutputs));
        % PlotResults(trainTargets,trainOutputs,trainTargetsnormal,trainOutputsnormal,'MLP Train Data');
        % 
        % valTargetsnormal=(valTargets-min(valTargets))/(max(valTargets)-min(valTargets));
        % valOutputsnormal=(valOutputs-min(valOutputs))/(max(valOutputs)-min(valOutputs));
        % PlotResults(valTargets,valOutputs,valTargetsnormal,valOutputsnormal,'MLP Validation Data');
        % 
        % testTargetsnormal=(testTargets-min(testTargets))/(max(testTargets)-min(testTargets));
        % testOutputsnormal=(testOutputs-min(testOutputs))/(max(testOutputs)-min(testOutputs));
        % PlotResults(testTargets,testOutputs,testTargetsnormal,testOutputsnormal,'MLP Test Data');

        % view(net)

    %     %% RBF training
    % 
    %     random_saver = 1;
    %     S_saver = 20;
    %     R=0.1;
    %     MaxNeuron_saver = 12;
    %     % while R<1.5
    %         nData=size(inputs,2);
    % 
    % %         rand('state', 126)
    %         Perm=randperm(nData);
    % 
    %     %     disp(['random saver: ' num2str(random_saver)])
    %     %     random_saver = random_saver + 1;
    % 
    %     %     Perm=1:nData;
    % 
    %         pTrainData=0.7;
    %         nTrainData=round(pTrainData*nData);
    %         trainInd=Perm(1:nTrainData);
    %         Perm(1:nTrainData)=[];
    %         trainInputs = inputs(:,trainInd);
    %         trainTargets = targets(:,trainInd);
    % 
    %         pTestData=1-pTrainData;
    %         nTestData=nData-nTrainData;
    %         testInd=Perm;
    %         Perm(1:nTestData)=[];
    %         testInputs = inputs(:,testInd);
    %         testTargets = targets(:,testInd);
    % 
    %         %% Create and Train RBF Network
    % 
    %         Goal=0;
    % 
    %         Spread=1;
    %     %     disp(['Spread Saver: ' num2str(S_saver)])
    %     %     S_saver=S_saver+0.1;
    % 
    %         MaxNeuron = 10;
    %     %     disp(['max neuron saver: ' num2str(MaxNeuron_saver)])
    %     %     MaxNeuron_saver = MaxNeuron_saver + 4;
    % 
    %     %     DisplatAt='off';
    %         net = newrb(trainInputs,trainTargets,Goal,Spread,MaxNeuron);
    % 
    %         % Test the Network
    %         outputs = net(inputs);
    %         errors = gsubtract(targets,outputs);
    %         performance = perform(net,targets,outputs);
    % 
    %         % Recalculate Training, Validation and Test Performance
    %         trainOutputs = outputs(:,trainInd);
    %         trainErrors = trainTargets - trainOutputs;
    %         trainPerformance = perform(net,trainTargets,trainOutputs);
    % 
    %         testOutputs = outputs(:,testInd);
    %         testError = testTargets-testOutputs;
    %         testPerformance = perform(net,testTargets,testOutputs);
    % 
    %         %% Get Best Model
    % 
    %         R111=corr(targets',outputs')^2;
    %         R222=corr(trainTargets',trainOutputs')^2;
    %         R444=corr(testTargets',testOutputs')^2;
    %         disp(['RBF All Data R^2: ' num2str(R111)])
    %         disp(['RBF Train Data R^2: ' num2str(R222)])
    %         disp(['RBF Test Data R^2: ' num2str(R444)])
    %         disp(' ')
    %     %         if R111>0.99 && R222>0.99 && R444>0.99
    %     %             break;
    %     %         end
    %     % end
    % 
    %     %% RBF's Plot
    % 
    %     % targetsnormal=(targets-min(targets))/(max(targets)-min(targets));
    %     % outputsnormal=(outputs-min(outputs))/(max(outputs)-min(outputs));
    %     % PlotResults(targets,outputs,targetsnormal,outputsnormal,'RBF All Data');
    % 
    %     % trainTargetsnormal=(trainTargets-min(trainTargets))/(max(trainTargets)-min(trainTargets));
    %     % trainOutputsnormal=(trainOutputs-min(trainOutputs))/(max(trainOutputs)-min(trainOutputs));
    %     % PlotResults(trainTargets,trainOutputs,trainTargetsnormal,trainOutputsnormal,'RBF Train Data');
    %     % 
    %     % testTargetsnormal=(testTargets-min(testTargets))/(max(testTargets)-min(testTargets));
    %     % testOutputsnormal=(testOutputs-min(testOutputs))/(max(testOutputs)-min(testOutputs));
    %     % PlotResults(testTargets,testOutputs,testTargetsnormal,testOutputsnormal,'RBF Test Data');

        %% MLP Training

        R = 0.1;
        random_saver = 0;
        hidden=1;

        % while R<1.5 
            % Create a Fitting Network
            hiddenLayerSize = 15;
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
%             rand('state',j)
            random_saver = random_saver + 1;
            disp(['random state MLP2= ' num2str(j)])
            net.divideFcn = 'dividerand';  % Divide data randomly
            net.divideMode = 'sample';  % Divide up every sample
            net.divideParam.trainRatio = 70/100;
            net.divideParam.valRatio = 15/100;
            net.divideParam.testRatio = 15/100;

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
        % tic;
            % Train the Network
            [net,tr] = train(net,inputs,targets);
        % toc;

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
            disp(['MLP All Data R^2: ' num2str(R111)])
            disp(['MLP Train Data R^2: ' num2str(R222)])
            disp(['MLP Test Data R^2: ' num2str(R444)])
            disp(' ')

        %     if R111>0.99 && R222>0.99 && R444>0.99
        %         break;
        %     end
        % end

        %% MLP's Plots

        % targetsnormal=(targets-min(targets))/(max(targets)-min(targets));
        % outputsnormal=(outputs-min(outputs))/(max(outputs)-min(outputs));
        % PlotResults(targets,outputs,targetsnormal,outputsnormal,'MLP All Data');

        % trainTargetsnormal=(trainTargets-min(trainTargets))/(max(trainTargets)-min(trainTargets));
        % trainOutputsnormal=(trainOutputs-min(trainOutputs))/(max(trainOutputs)-min(trainOutputs));
        % PlotResults(trainTargets,trainOutputs,trainTargetsnormal,trainOutputsnormal,'MLP Train Data');
        % 
        % valTargetsnormal=(valTargets-min(valTargets))/(max(valTargets)-min(valTargets));
        % valOutputsnormal=(valOutputs-min(valOutputs))/(max(valOutputs)-min(valOutputs));
        % PlotResults(valTargets,valOutputs,valTargetsnormal,valOutputsnormal,'MLP Validation Data');
        % 
        % testTargetsnormal=(testTargets-min(testTargets))/(max(testTargets)-min(testTargets));
        % testOutputsnormal=(testOutputs-min(testOutputs))/(max(testOutputs)-min(testOutputs));
        % PlotResults(testTargets,testOutputs,testTargetsnormal,testOutputsnormal,'MLP Test Data');

        %% All New Combination's Calculations RBF

        outputs_AllNewCombinations_RBF = net(AllNewCombinations);
%         aa2 = find(outputs_AllNewCombinations_RBF<=0);
%         outputs_AllNewCombinations_RBF(aa2) = [];
%         bb2 = find(outputs_AllNewCombinations_RBF>=100);
%         outputs_AllNewCombinations_RBF(bb2) = [];

    %     outputs_AllNewCombinations_MLP_normal=(outputs_AllNewCombinations_MLP-min(outputs_AllNewCombinations_MLP))/(max(outputs_AllNewCombinations_MLP)-min(outputs_AllNewCombinations_MLP));
    %     outputs_AllNewCombinations_RBF_normal=(outputs_AllNewCombinations_RBF-min(outputs_AllNewCombinations_RBF))/(max(outputs_AllNewCombinations_RBF)-min(outputs_AllNewCombinations_RBF));
    %     PlotResults(outputs_AllNewCombinations_MLP_normal,outputs_AllNewCombinations_RBF,outputs_AllNewCombinations_MLP_normal,outputs_AllNewCombinations_RBF_normal,'Combined Data');

        %% Check Created Data

        R111=corr(outputs_AllNewCombinations_MLP',outputs_AllNewCombinations_RBF')^2;
        disp(['Checking Created Data R^2: ' num2str(R111)])
        disp(' ')
        if R111>0.9
            break;
        end        
    end
    
    if R111>0.7
        break;
    end
end


outputs_AllNewCombinations_MLP_normal=(outputs_AllNewCombinations_MLP-min(outputs_AllNewCombinations_MLP))/(max(outputs_AllNewCombinations_MLP)-min(outputs_AllNewCombinations_MLP));
outputs_AllNewCombinations_RBF_normal=(outputs_AllNewCombinations_RBF-min(outputs_AllNewCombinations_RBF))/(max(outputs_AllNewCombinations_RBF)-min(outputs_AllNewCombinations_RBF));
PlotResults(outputs_AllNewCombinations_MLP_normal,outputs_AllNewCombinations_RBF,outputs_AllNewCombinations_MLP_normal,outputs_AllNewCombinations_RBF_normal,'Combined Data');































