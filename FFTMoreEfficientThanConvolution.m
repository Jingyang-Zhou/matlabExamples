% FFTMoreEfficientThanConvolution

% Running this file might take a few minutes


numTimeLength = 10;

timeStopConv  = zeros(1, numTimeLength);
timeStopFFT   = zeros(1, numTimeLength);


for timeLength = 1 : numTimeLength

time = 1 : 5^timeLength ;

% stimulus:

stimulus         = zeros(size(time));
stimulus (1:300) = 1;
lengthStim       = length(stimulus);


% impulse:

impulse          = zeros(size(time));
impulse(1:100)   = 0.5;
lengthImp        = length(impulse);


% extend the two vectors to length length(time) * 2 - 1:

stimulus         = padarray(stimulus, [0, lengthImp ], 'post');
impulse          = padarray(impulse, [0, lengthStim ], 'post');

% FFT stimulus and impulse : 

ftStimulus       = fft(stimulus);
ftImpulse        = fft(impulse);


% convolution

tic;
output           = conv(stimulus, impulse);
output           = output(1 : length(stimulus));

timeStopConv(timeLength) = toc;


% fft (convolution in the time domain = multiplication in the Fourier domain)

tic;
ftOutput         = ifft(ftStimulus.* ftImpulse);

timeStopFFT(timeLength) = toc;

end
%% Compare output computed in two ways

figure (1), clf
subplot(3, 1, 1)
plot(output)
xlim([0, 5000]), grid on
title('Output by convolution')
ylabel('amplitude')


subplot(3, 1, 2)
plot(ftOutput)
xlim([0, 5000]), grid on
title('Output by fft')
xlabel('time (ms)')
ylabel('amplitude')

subplot(3, 1, 3)
plot(timeStopConv - timeStopFFT, '.-'), hold on
plot(1 : numTimeLength, zeros(1, numTimeLength), ':')
title('convolution time - fft time')
ylabel('difference')
