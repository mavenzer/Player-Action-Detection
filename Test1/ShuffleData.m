function [ SDS ] = ShuffleData( DS )
%Input : DS -> Sequential DataSet
%Output : SDS -> Shuffled Dataset

    numofobs=length(DS.Data);
    rearrangement= randperm(numofobs);
    SDS.Data=DS.Data(rearrangement,:);
    SDS.Labelidx=DS.Labelidx(rearrangement);
    SDS.Label = DS.Label;

end

