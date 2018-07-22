function [ videoFeature ] = ExtractGHOF( V, P )
% Input: V -> VideoReader object for the video
%        P -> States Added or concatinated feature
% Output: videoFeature -> HOF feature vector

    for i = 1:25
        videoVol(:,:,i) = rgb2gray(readFrame(V));
    end
    opticFlow = opticalFlowFarneback;
%   Extract features
%   -------------------------------------------------------------------------
    shiAll = []; % the variable that contains all the features.
    for v2 = 1:size(videoVol,3)     % for each frame

        flow = estimateFlow(opticFlow,videoVol(:,:,v2));    % estimate field flow
      if v2 < 2   % drop the first frame in the sequence
          continue
      end
    
        coarseHist = calFuzzyHist(flow);  % compute feature vector for each frame
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

