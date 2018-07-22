function ExtractSoccerVDOData( )
%Output : Saves the structure of Data (DS)
%         FileName -> 'SequentialData.mat'
%         DS -> Structure containing Dataset
%         DS.Data -> VideoReader object of the video data
%         DS.Labelidx -> Corresponding Label index
%         DS.Label -> Corresponding Labels

    ind = 1;
    addpath('Dataset\Dribble');
    i = 1;
    while(1)
        DS.Label{1,1} = 'Dribble';
        str = ['Dribble (' int2str(i) ').mp4'];
        if exist(str, 'file')
            DS.Data(ind,1) = VideoReader(str);
            DS.Labelidx(ind,1) = 1;
            ind = ind + 1;
            i = i + 1;
        else
            break;
        end
    end
    addpath('Dataset\Kick');
    i = 1;
    while(1)
        DS.Label{2,1} = 'Kick';
        str = ['Kick (' int2str(i) ').mp4'];
        if exist(str, 'file')
            DS.Data(ind,1) = VideoReader(str);
            DS.Labelidx(ind,1) = 2;
            ind = ind + 1;
            i = i + 1;
        else
            break;
        end
    end
    addpath('Dataset\Run');
    i = 1;
    while(1)
        DS.Label{3,1} = 'Run';
        str = ['Run (' int2str(i) ').mp4'];
        if exist(str, 'file')
            DS.Data(ind,1) = VideoReader(str);
            DS.Labelidx(ind,1) = 3;
            ind = ind + 1;
            i = i + 1;
        else
            break;
        end
    end
    addpath('Dataset\Walk');
    i = 1;
    while(1)
        DS.Label{4,1} = 'Walk';
        str = ['Walk (' int2str(i) ').mp4'];
        if exist(str, 'file')
            DS.Data(ind,1) = VideoReader(str);
            DS.Labelidx(ind,1) = 4;
            ind = ind + 1;
            i = i + 1;
        else
            break;
        end
    end
%     addpath('Dataset\Head');
%     i = 1;
%     while(1)
%         DS.Label{5,1} = 'Head';
%         str = ['Walk (' int2str(i) ').mp4'];
%         if exist(str, 'file')
%             DS.Data(ind,1) = VideoReader(str);
%             DS.Labelidx(ind,1) = 5;
%             ind = ind + 1;
%             i = i + 1;
%         else
%             break;
%         end
%     end
    save('SequentialData.mat','DS');

end

