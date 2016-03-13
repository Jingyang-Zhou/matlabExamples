% explore errorbar

%% generate 10 sets of random numbers

randNum = zeros(100, 10);

for k = 1 : size(randNum, 2)
   randNum(:, k) = randn([1, size(randNum, 1)]).*k/2 ;
end

meanRandNum = mean(randNum);
stdRandNum  = std(randNum);

%% plotting

figure (1), clf
subplot(1, 2, 1)
errorbar(1 : size(randNum, 2), meanRandNum, stdRandNum, '.', 'lineWidth', 2)

subplot(1, 2, 2)
for k = 1 : size(randNum, 2)
   errorbar(k, meanRandNum(k), stdRandNum(k), '.', 'lineWidth', 2), hold on
end