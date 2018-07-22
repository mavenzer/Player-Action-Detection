clear; clc;
network = alexnet;
net = SeriesNetwork(network.Layers(1:end-2));
V = VideoReader('Run.mp4');
Fea = [];
for i = 1:25
    temp = readFrame(V);
    temp1 = imresize(temp,[227,227]);
    Fea = cat(2,Fea,predict(net,temp1));
    clear temp temp1;
end
