function [ videoFeature ] = ExtractGLBP( V )
% Input: V -> VideoReader object for the video
% Output: videoFeature -> LBP feature vector

    for i = 1:25
        videoVol(:,:,i) = rgb2gray(readFrame(V));
    end
    shiAll = []; % the variable that contains all the features concatenated for all the frames.
    for v2 = 1:size(videoVol,3)     % for each frame
        LBPFeature = Modified_LBP(videoVol(:,:,v2));  % compute feature vector for each frame
%       shiAll = cat(2,shiAll,LBPFeature);  % concatenate the features for all frames
        if v2 == 1
            shiAll = LBPFeature;
        else
            shiAll = shiAll + LBPFeature;
        end
    end
    videoFeature = shiAll;   % the feture that describes the LBP in the video

end

