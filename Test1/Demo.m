clear; clc;
addpath('Dataset');
addpath('Results');
if ~exist('SequentialData.mat', 'file')
    ExtractSoccerVDOData();
end
Pattern = 'Results\';

% For Added Feature
Par = 'AddFea';
Pattern = [Pattern 'AD_'];

% For concatinated Feature
% Par = 'Concat';
% Pattern = [Pattern 'CON_'];

load('SequentialData.mat');
SDS = ShuffleData(DS);
for i = 1:length(SDS.Data)
    
%     For Histogram of Optical Flow applied Globally
    if i == 1
        Pattern = [Pattern 'GHOF'];
    end
    Result.FV(i,:) = ExtractGHOF(SDS.Data(i,1),Par);

%     For Histogram of Optical Flow applied Locally
%     if i == 1
%         Pattern = [Pattern 'LHOF'];
%     end
%     Result.FV(i,:) = ExtractLHOF(SDS.Data(i,1),Par);
    
%     For Local Binary Pattern applied Globally
%     if i == 1
%         Pattern = [Pattern 'GLBP'];
%     end
%     Result.FV(i,:) = ExtractGLBP(SDS.Data(i,1),Par);
    
%     For Local Binary Pattern applied Locally
%     if i == 1
%         Pattern = [Pattern 'LLBP'];
%     end
%     Result.FV(i,:) = ExtractLLBP(SDS.Data(i,1),Par);

%     For Concatinated Globally applied Feature
%     if i == 1
%         Pattern = [Pattern 'GHOF_GLBP'];
%     end
%     Result.FV(i,:) = GlobalFeaConcat(SDS.Data(i,1),Par);
    
%     For Concatinated locally applied Feature
%     if i == 1
%         Pattern = [Pattern 'LHOF_LLBP'];
%     end
%     Result.FV(i,:) = LocalFeaConcat(SDS.Data(i,1),Par);
    
end
clear DS;
NF = 10;
cvFolds = crossvalind('Kfold', SDS.Labelidx, NF);
Result.cp(1:NF) = classperf(SDS.Labelidx);

for i = 1:NF
    testIdx = (cvFolds == i);
    trainIdx = ~testIdx;
    
%     SVM Classifier
    if i == 1
        Pattern = [Pattern '_SVM'];
    end
    Model = fitrsvm(Result.FV(trainIdx,:), SDS.Labelidx(trainIdx), 'KernelFunction','rbf');
    pred = round(predict(Model,Result.FV(testIdx,:)));
    
%     Random Forest Classier
%     if i == 1
%         Pattern = [Pattern '_RF'];
%     end
%     NT = 10;
%     Model = TreeBagger(NT, Result.FV(trainIdx,:), SDS.Labelidx(trainIdx));
%     predArr = cell2mat(predict(Model,Result.FV(testIdx,:)));
%     for j = 1:length(predArr)
%         pred(j,1) = str2double(predArr(j));
%     end
%     clear predArr;

%     Measuring Individual Performance
    Result.cp(i) = classperf(Result.cp(i), pred, testIdx);
    Result.Accuracy(i) = (Result.cp(i).CorrectRate)*100;
    clear pred Model;
end

% Measuring Overall Performance
Result.MinAccuracy = min(Result.Accuracy);
Result.MeanAccuracy = mean(Result.Accuracy);
Result.MaxAccuracy = max(Result.Accuracy);
save([Pattern '_Result.mat'],'Result');
clearvars -except Result;
