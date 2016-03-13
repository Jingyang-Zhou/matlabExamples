% example of how to use ShineToolbox.

% Description: ShineToolbox is not limited to equalize luminance
% distribution between two images. In here, we are going to use match.m only.


% DEPENDENCIES ----------------------------------
% match.m in the SHINEToolbox



%% change path and add directories:

% feel free to change the directory to where you store Shinetoolbox:
projectDir = '~/matlab/SHINEtoolbox/';

addpath(genpath(projectDir))

%% load two images from the Shinetoolbox:

extractOneColor = @(image) image(:, :, 1);

template = imresize(extractOneColor(imread('office_3.jpg')), [600, 600]);
%toMatch  = imresize(extractOneColor(imread('onion.png')), [600, 600]);

toMatch = template;

fg1 = figure (1), clf,
subplot(2, 2, 1), colormap gray
imagesc(template)
title('template')

subplot(2, 2, 2)
imagesc(toMatch)
set(fg1, 'Name', 'original Images')
title('image to be matched')

subplot(2, 2, 3)
hist(double(template(:))),
axis tight
title('luminance distribution for template')

subplot(2, 2, 4)
hist(double(toMatch(:))),
axis tight
title('distribution for image to be matched')

%% define mask

v           = linspace(-1, 1, size(template, 1));
[x, y]      = meshgrid(v, v);
maskedRange = sqrt(2.5*x.^2 + 0.7*y.^2)< 0.8;

%% compute using SHINEtoolbox

outputImage = match(toMatch, sort(template(:)), maskedRange);


%% plot final results
figure (2), clf, colormap gray

subplot(3, 2, 1)
imagesc(maskedRange)
title('image mask')

subplot(3, 2, 3)
imagesc(template)
title('original image')

subplot(3, 2, 4)
imagesc(outputImage)
title('luminance-equalized image')

subplot(3, 2, 5)
hist(double(template(:)))

subplot(3, 2, 6)
hist(double(toMatch(:)))

