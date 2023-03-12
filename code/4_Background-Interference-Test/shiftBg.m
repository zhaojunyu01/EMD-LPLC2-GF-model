function PATT = shiftBg(tao)
%SHIFTBG Looming stimuli with shifting background
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20,2022

directory = [pwd,'\videoFrames'];
dirs = dir(directory);
dircell = struct2cell(dirs)';
filenames = dircell(:,1);
[n, ~] = size(filenames); 
j = 0;
for i = 1:n
    if ~isempty(strfind(filenames{i}, 'jpg'))
        j = j+1;
        filename = filenames{i};
        filepath = fullfile(directory,filename);
        BgImg(:,:,j) = imread(filepath);            % uint8[0 255];
    end
end

% black Fg
anti_BgImg = 255-BgImg;
anti_Bg = imresize(anti_BgImg, [300,400]);

patt_1 = loomingObject(tao);               % double[0 1]; Bg = 1, Fg = 0;
patt = patt_1(1:2:end,1:2:end,:);
patt = im2uint8(patt);                                        % uint8[0 255]; Bg = 255, Fg = 0;
PATT = patt-anti_Bg;                                          % uint8[0 255] spillover effect
PATT = im2double(PATT);
end
