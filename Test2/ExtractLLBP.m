function [ videoFeature ] = ExtractLLBP( V )
% Input: V -> VideoReader object for the video
% Output: videoFeature -> LBP feature vector

    for i = 1:25
        videoVol(:,:,i) = rgb2gray(readFrame(V));
    end
    shiAll = []; % the variable that contains all the features concatenated for all the frames.
    for v2 = 1:size(videoVol,3)     % for each frame
        
        % compute feature vector for each frame parts
        LBPFeature = Modified_LBP(videoVol(1:50,1:50,v2));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(1:50,51:100,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(1:50,101:150,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(51:100,1:50,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(51:100,51:100,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(51:100,101:150,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(101:150,1:50,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(101:150,51:100,v2)));
        LBPFeature = cat(2,LBPFeature,Modified_LBP(videoVol(101:150,101:150,v2)));
%       shiAll = cat(2,shiAll,LBPFeature);  % concatenate the features for all frames
        if v2 == 1
            shiAll = LBPFeature;
        else
            shiAll = shiAll + LBPFeature;
        end
    end
    videoFeature = shiAll;   % the feture that describes the LBP in the video

end
