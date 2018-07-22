function coarseHist1 = calFuzzyHist(flow,param)
% Computing Fuzzy Histogram of Optical Flow Orientations
%
% Input :   flow - opticalFlow Object for storing optical flow field
%           param - parameters for computing FHOFO/FHOOF            
%                 param.feature : {'fhofo','fhoof'}
%                 param.n_1 : number of fine histogram bins  
%                 param.n_2 : number of coarse histogram bins   
%                 param.sigma : variance used in memebrship function
% Output:   coarseHist - the resulting coarse histogram after feature extraction


if nargin == 1
    param.feature = 'fhofo'; 
    param.n_1 = 50;  
    param.n_2 = 18;   
    param.sigma = 10; 
end
n_1 = param.n_1;
n_2 = param.n_2;
sigma = param.sigma;

% get the index of pixels having zero magnitude flow and remove them
flowOri = flow.Orientation;
flowOri(flow.Magnitude==0) = NaN;
if strcmpi(param.feature,'FHOOF')
    % gettting the weighted histogram for FHOOF
    intervals = linspace(-pi,pi,n_1+1);
    pixelsProcessed = false(size(flow.Magnitude));
    fine_hist = zeros(1,n_1);
    for v = 2:length(intervals)
        idx = (flowOri <= intervals(v)) & ~pixelsProcessed;
        fine_hist(v-1) = sum(flow.Magnitude(:).*idx(:));
        pixelsProcessed = pixelsProcessed | idx;
    end
    fineHist = fine_hist/sum(fine_hist);
elseif strcmpi(param.feature,'FHOFO')
    % get the fine histogram vector (n_1 bins) for FHOFO
    binCenters = linspace(-pi,pi,n_1+1);
    binCenters = binCenters+(binCenters(2)-binCenters(1))/2;
    binCenters = binCenters(1:numel(binCenters)-1);
    fineHist = hist(flowOri(:),binCenters);
else
    error('The feature should be one of these: FHOFO,FHOOF')
end
%%% create the fine to coarse mapping matrix
M2 =  hist_fine2coarseMapping(n_1,n_2,sigma);
%%% for improving speed construct M2 in the main program and uncomment the
%%% following 2 lines and comment the above line
% global M2
% if isempty(M2), M2 =  hist_fine2coarseMapping(n_1,n_2,sigma); end

% calculate the coarse histogram
coarseHist = M2*fineHist';

% normalize
coarseHist = coarseHist/(eps+sum(coarseHist));
coarseHist1 = coarseHist';
end

