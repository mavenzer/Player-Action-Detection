clear; clc;
V = VideoReader('Run (1).mp4');
% FV(1,:) = ExtractGLBP(V);
FV(1,:) = ExtractLLBP(V);
