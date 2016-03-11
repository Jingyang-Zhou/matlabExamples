% Understand a Weibull function


weibull1 = @(intensity, lambda, k) 1 - exp(-(intensity / lambda).^k);

% re-parametrized Weibull

% g : performance expected at chance
% t : threshold
% a : performance level that defines the threshold
% b : slope of the Weibull function

savePth = '/Volumes/server/Projects/Temporal integration/Behavioral/Analysis/code';
cd(savePth)


%% form of the Weibull function (two free parameter lambda and k)

lambda    = 1; 
k         = 1;
intensity = 0 : 0.05 : 5;

pctCorrect = weibull1(intensity, lambda, k);

figure (1), clf
plot(intensity, pctCorrect)
xlabel('intensity'), ylabel('pct. correct')
title('Understand Weibull 1 : example Weibull function')


%% How Weibull function depends on lambda and k:

lambda1     = linspace(0.1, 1., 10);
k1          = linspace(0.1, 1, 10);
pctCorrect1 = [];
pctCorrect2 = [];

for count = 1 : 10
   pctCorrect1(count, :) = weibull1(intensity, lambda1(count), 1);
   pctCorrect2(count, :)  = weibull1(intensity, 1, k1(count));

end


figure (2), clf
subplot(1, 2, 1)
plot(pctCorrect1'), hold on
title('Understand Weibull 2 : changing lambda')
legend(num2str(lambda1'))

subplot(1, 2, 2)
plot(pctCorrect2'), hold on
title('Understand Weibull 2 : changing k')
legend(num2str(k1' ))

% Conclusion : loosely speaking, lambda is controlling thresholds and k is
% controling slope. In our case we may need to fix k to fit lambda. 


%% Example Weibull fit (using one duration level to fit a Weibull)

dataPth = '/Volumes/server/Projects/Temporal integration/Behavioral/Data/motionDuration/';
clear dataSum

load(fullfile(dataPth, 'JYZ_Contrast_8Dur20151225.mat'));

% dataSum.history    : contrast levels presented at certain stimulus duration
%                      throughout the experiment
% dataSum.response   : which key is pressed for each stimulus presentation at
%                      certain stimulus duration
% dataSum.correct    : whether each response is correct
% dataSum.trialCount : certain stimulus duration is presented at which
%                      trial
% dataSum.numTrials  : number of trials at each stimulus level

% In here, we need dataSum.history and dataSum.correct

data.intensity = dataSum(5).history;
data.correct   = dataSum(5).correct;


%% Plot data:

[intensity, order] = sort(data.intensity);
correct            = data.correct(order);
levels             = intensity(1);

% calculating levels
for k = 2 : length(intensity)
    if intensity(k) ~= intensity(k-1)
        levels = [levels, intensity(k)];
    end
end

% calculating levelCounts
levelCounts   = zeros(1, length(levels));
correctLevels = zeros(1, length(levels));
pctCorrect    = zeros(size(correctLevels));

% calculating the number of correct trials at each level:
for k = 1 : length(intensity)
    levelCounts( find(levels == intensity(k)))  = levelCounts( find(levels == intensity(k))) + 1;
    correctLevels(find(levels == intensity(k))) = correctLevels(find(levels == intensity(k))) + correct(k);
end

pctCorrect = correctLevels./levelCounts * 100;

figure (3), clf

for k1 = 1 : length(levelCounts)
    semilogx(levels(k1), pctCorrect(k1), 'k.','markerSize', levelCounts(k1)*10), hold on
end

xlabel('contrast intensity')
ylabel('percentage correct')
axis tight, grid on
title('proportion Correct at each contrast level (dur = 32 frames)')


%% fit a Weibull function to the data and calculate likelihood

p.t = 0.01;
p.b = .4;

y = Weibull(p, levels).*100;

figure (3)
semilogx(levels, y)

% calculate likelihood
y = y.*.99 + 0.005; % prevent y from being 100 and 0

y1 = y./100;
likelihood = prod(y1.^(correctLevels).*(1 - y1).^(levelCounts - correctLevels));

% calculate log likelihood

%logResult = sum(log(y1) .*correctLevels +log(1 - y1) .* (levelCounts - correctLevels));

logResult = logLikelihood(y1, correctLevels, levelCounts);


%% Create log-likelihood surface

% list of b values and t values 

bList = linspace(0, 1.5, 201);
%tList = exp(linspace(log(.05), log(.25), 31));
tList = linspace(0.001, 1, 201);

logLikelihoodSurface = zeros(length(bList), length(tList));


for i = 1 : length(bList)
   for j = 1 : length(tList) 
       
       p.b = bList(i);
       p.t = tList(j);
       
       yy = Weibull(p, levels);
       yy = yy.*.99 + 0.005;
      logLikelihoodSurface(i, j) = -logLikelihood(yy, correctLevels, levelCounts);
    
   end
end

% visualize the results

figure (4), clf

contour(log(tList), bList, logLikelihoodSurface, 80), hold on
xlabel('log(threshold parameter)')
ylabel('slope parameter')
title('contour Plot of log Likelihood')

plot(log(0.01), .4, '.', 'markerSize', 30)


%% Searching for the best parameter fit 

my_options = optimset('Display', 'iter', 'Algorithm', 'trust-region-reflective', 'MaxIter', 1000);


init = [0.01, .4];

% indiLinearParams{iSubject, iroi} = fminsearch(@(x) fitLinearModel(x, condition, ...
%     meanGroupROIBetas{iSubject, iroi}([25:48, 50])), linearInit, my_options);

%fitWeibull(parameters,levels, correctLevels, levelCounts)

parameters = fminsearch(@(x) fitWeibull(x, levels, correctLevels, levelCounts, 'both'), init, my_options);

figure (4)
plot(log(parameters(1)), parameters(2), 'r.', 'markerSize', 30)

figure (3)
x.t = parameters(1);
x.b = parameters(2);
semilogx(levels, Weibull(x, levels).*100);










