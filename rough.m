folderSet = dir('G:/sem 8/testing*');
for folder = 1: (size(folderSet, 1 ))
    imgFolder = dir(fullfile('G:/sem 8',folderSet(folder).name,'connect/Image*'));
    segAddr = fullfile( 'G:\sem 8', folderSet(folder).name,'segmented');
    mkdir(segAddr);
    for img = 1:size(imgFolder, 1)
        fileAddr = fullfile('G:/sem 8',folderSet(folder).name,'connect',imgFolder(img).name,'segmentedImage.png');
        a = imread(fileAddr);
        imwrite(a,fullfile(segAddr,strcat(imgFolder(img).name,'.png')));
    end
end
        