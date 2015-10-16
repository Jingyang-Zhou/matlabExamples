% exercises of making sitmuli

% In this exercise, we are going to use face images, we are going to try a
% few things with the face images, and you can always find new things that
% you can do with the images.

%% load images, and add useful paths

imagePth = '/Volumes/server/Projects/Temporal integration/Project_temp_int_fMRI/stimulus';
cd(imagePth)

if ~exist ('images', 'var')
    load ('allrangefacesC5_size4frontal.mat');
end

projectPth = '/Volumes/server/Projects/Temporal integration/experiment_behavioral/Stimulus/';
toolPth    = '/Volumes/server/Projects/Temporal integration/utils';

cd(projectPth)
addpath(genpath(toolPth))

%% Image manipulation 1: re-scale intensity
% work on one example face
face = images(:,:, 1);

% maximum and minimum intensity of the exampleFace:
max_face = max(face(:))
min_face = min(face(:))

% since intensities are ranging from 0 to 255, let's re-scale them to
% between 0 and 1 first, re-scaling image intensity sometimes makes image
% manipulation more intuitive, but it is not necessary.

rescaledFace = (face - min_face)./max_face;

% check intensity distribution before and after rescaling


figure (1), clf, colormap gray
subplot(2, 2, 1)
imagesc(exampleFace)

subplot(2, 2, 2)
imagesc(rescaledFace)

subplot(2, 2, 3)
hist(face(:))

subplot(2, 2, 4)
hist(rescaledFace(:))

% Notice that the two images look the same because I used imagesc command
% (image rescale), try using "image command.

%% Image manipulation 2: change image contrast

% We use something like this for staircasing contrast experiment, for
% example.

% mean image intensity:
meanIntensity = mean(rescaledFace(:));

% compute the difference between the image and its mean:
diff = rescaledFace - meanIntensity;

% rescale the difference:
diff1 = diff .* 0.5;
diff2 = diff .* 0.2;

face1 = meanIntensity + diff;
face2 = meanIntensity + diff1;
face3 = meanIntensity + diff2;

figure (2), clf, colormap gray
subplot(2, 3, 1)
imagesc(face1),
caxis([0, 1])

subplot(2, 3, 2)
imagesc(face2)
caxis([0, 1])

subplot(2, 3, 3)
imagesc(face3)
caxis([0, 1]),

subplot(2, 3, 4)
hist(face1(:)), xlim([0, 1])

subplot(2, 3, 5)
hist(face2(:)), xlim([0, 1])

subplot(2, 3, 6)
hist(face3(:)), xlim([0, 1])

% what would the images look like if we use the median intensity instead of
% mean intensity to compute the difference?

%% Image manipulation 3: change a particular color in the image

% I never used this, but I think it would be a fun and creepy thing to do :

% find dark pixels in the original image

[x, y]       = find(face1 < 0.1);
coloredFace1 = face1;

for k =  1 : length(x)
    coloredFace1(x(k), y(k)) = 1;
end

[x1, x2]     = find(face1 >  0.6);
coloredFace2 = face1;

for k1 = 1 : length(x1)
    coloredFace2(x1(k1), x2(k1)) = 0;
end

figure (3), clf, colormap gray
subplot(1, 2, 1)
imagesc(coloredFace1)

subplot(1, 2, 2)
imagesc(coloredFace2)

%% Image manipulation 4: phase scramble the image

% compute the Fourier transform of the image
amplitude = abs(fft2(face1));
phase     = angle(fft2(face1));
newPhase(:, :, 1) = phase + (rand(size(face1))-0.5)*0.2 * pi * 2;
newPhase(:, :, 2) = phase + (rand(size(face1))-0.5)*0.6 * pi * 2;
newPhase(:, :, 3) = phase + (rand(size(face1))-0.5) * pi * 2;

for kk = 1 : 3
    phaseScrambledImage(:, :, kk) = real(ifft2(abs(amplitude) .* exp(i*newPhase(:,:, kk))));
end

figure (4), clf, colormap gray
for kk1 = 1 : 3
    subplot(1, 3, kk1)
    imagesc(phaseScrambledImage(:, :, kk1)), hold on
end

