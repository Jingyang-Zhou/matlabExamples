% To understand the beginning and ending of convolution in fMRI:



vector1   = square(0:0.01:100, 30)+5;
vector2   = sin(0:0.01:2*pi);

vector1   = padarray(vector1, [0, 400], 4, 'pre');
vector2   = padarray(vector2, [0, length(vector1) - length(vector2)], 'post');

convVect1 = conv_cut(vector1, vector2, length(vector1) + 625);
frq1      = fft(convVect1);
frq1      = frq1(1:round(length(frq1)/2));

convVect2 = conv_cut(vector1, vector2, length(vector1));
frq2      = fft(convVect2);
frq2      = frq2(1:round(length(frq2)/2));


%% Plotting the results 

fg = figure (1), clf

subplot(5, 1, 1)
plot(vector1), axis tight, hold on
ylim([min(vector1) - 0.5, max(vector1) + 0.5])
title('stimulus has 16 cycles'), 
set(gca, 'xTick', 0:625:length(vector1)), 
grid on

subplot(5, 1, 2)
plot(vector2), 
axis tight
ylim([min(vector2) - 0.5, max(vector2) + 0.5])
title('some sluggish response function')
set(gca, 'xTick', 0:625:length(vector1)), 
grid on

subplot(5, 1, 3)
plot(convVect1)
axis tight
ylim([min(convVect1) - 0.5, max(convVect1) + 0.5])
set(gca, 'xTick', 0:625:length(vector1)), 
grid on
title('convolution outcome')

subplot(5, 1, 4)
% FFT of the outcome
stem(abs(frq1))
axis tight
xlim([0, 100])
title('FFT of the convolution outcome including the last part')
set(gca, 'xTick', [0:16:100]), grid on

subplot(5, 1, 5)
stem(abs(frq2))
xlim([0, 100])
title('FFT of the convolution outcome excluding the last part')
set(gca, 'xTick', [0:16:100]), grid on

set(fg, 'Position', [100, 100, 1000, 1000])

%% some simple calculations:

% If the Hemodynamic function lasts for about 30 seconds, and the
% experiment lasts for 216 seconds (48 * 1.5 * 3), the whole effective time
% series is about 156 (126 + 30) seconds. Or if the HRF effective period is
% around 10 seconds, we may have aout 10 seconds non-cyclic activity at the
% front, and around 10 at the back. 