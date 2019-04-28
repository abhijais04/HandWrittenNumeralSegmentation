folderSet = dir('G:\sem 8\testing*');
for folder = 1 : (size( folderSet, 1 ))
    folderName = folderSet(folder).name;
    mkdir( fullfile( 'G:\sem 8', folderName, 'connect'));
    mkdir( fullfile( 'G:\sem 8', folderName, 'isolated'));
    mkdir( fullfile( 'G:\sem 8', folderName, 'confused'));
    mkdir( fullfile( 'G:\sem 8', folderName, 'dilatedImage'));
    fileSet = dir( fullfile('G:\sem 8', folderName, '*.png' ));
    for file = 1 : (size( fileSet, 1 ))
        fileAddr = fullfile('G:\sem 8', folderName, fileSet(file).name);
        a = imread( fileAddr );
        % we are not reading the image here just so that we don't have to
        % transfer the image as the data, which will optimize the work.
        
        % by this loop we are accessing each file in each folder of the
        % dataset.
        % now we need to seperate all the possible components and then
        % apply the function on each of them.
        % OR
        % we apply the function on each of the files directly, without
        % thinking about the possibility of noise and other things.
        % OR
        % we remove noise from the image first and then apply the reservoir
        % file on the image directly. ( I think this is the best one as we
        % won't have to take care of all the component seperation and all
        % in this file because it is part of whole different loop.)
        %
        %
        % on each file we need to apply the reservoir file as a function
        % and find if it is connected or not.
        %
        % call the function here. %%%%%%
        val = reservoir(fileAddr,folderName, fileSet(file).name);
        
        
    end
    %break;
end