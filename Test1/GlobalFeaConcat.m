function [ videoFeature ] = GlobalFeaConcat( V, P )
% Input: V -> VideoReader object for the video
%        P -> States Added or concatinated feature
% Output: videoFeature -> Concatinated LHOF and LLBP feature vector

    shiAll = []; % the variable that contains all the features.
    shiAll = cat(2,shiAll,ExtractGHOF(V,P));
    V.CurrentTime = 0;
    shiAll = cat(2,shiAll,ExtractGLBP(V,P));
    videoFeature = shiAll;

end

