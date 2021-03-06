% exploreVideoWriter


%% define a temporary location to save the file

filLoc  = '/Desktop/temporary';
rootPth = temporalRootPath;
imgLoc  = fullfile(rootPth, 'Stimulus', 'ECoGstimulus');
matName = 'ECoG_LineImages.mat';

a        = load(fullfile(imgLoc, matName));
img      = a.images;
firstImg = squeeze(img(:, :, 1));


%% Create a new file:

v = VideoWriter('contrast.avi');
open(v)

figure (1), clf, colormap gray
imagesc(firstImg)
axis tight, axis off

for k = 1 : 100
    
    toShow = mean(firstImg(:)) + sin(k * 200 / (2*pi)).* (firstImg - mean(firstImg(:)));
    imagesc(toShow), caxis([0, 255])
    
    frame = getframe;
    writeVideo(v,frame);
end

close(v)

%% Visuzlie the images

implay('contrast.avi')

