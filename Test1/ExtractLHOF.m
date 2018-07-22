function [ videoFeature ] = ExtractLHOF( V, P )
% Input: V -> VideoReader object for the video
%        P -> States Added or concatinated feature
% Output: videoFeature -> HOF feature vector

    for i = 1:25
        videoVol(:,:,i) = rgb2gray(readFrame(V));
    end
    opticFlow = opticalFlowFarneback;
%   Extract features
%   -------------------------------------------------------------------------
    shiAll = []; % the variable that contains all the features
    for v2 = 1:size(videoVol,3)     % for each frame

        % estimate local field flows
        flow1 = estimateFlow(opticFlow,videoVol(1:50,1:50,v2)); 
        flow2 = estimateFlow(opticFlow,videoVol(1:50,51:100,v2));
        flow3 = estimateFlow(opticFlow,videoVol(1:50,101:150,v2));
        flow4 = estimateFlow(opticFlow,videoVol(51:100,1:50,v2));
        flow5 = estimateFlow(opticFlow,videoVol(51:100,51:100,v2));
        flow6 = estimateFlow(opticFlow,videoVol(51:100,101:150,v2));
        flow7 = estimateFlow(opticFlow,videoVol(101:150,1:50,v2));
        flow8 = estimateFlow(opticFlow,videoVol(101:150,51:100,v2));
        flow9 = estimateFlow(opticFlow,videoVol(101:150,101:150,v2));
      if v2 < 2   % drop the first frame in the sequence
          continue
      end
    
        % compute feature vector for each frame parts
        coarseHist = calFuzzyHist(flow1);
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow2));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow3));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow4));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow5));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow6));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow7));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow8));
        coarseHist = cat(2,coarseHist,calFuzzyHist(flow9));
      if P == 'Concat'
        shiAll = cat(2,shiAll,coarseHist);  % concatenate the features for all frames
      else
        if v2 == 2
            shiAll = coarseHist;
        else
            shiAll = shiAll + coarseHist;
        end
      end
    end

    videoFeature = shiAll;   % the feture that describes the motion in terms of angular histograms in the video


end
