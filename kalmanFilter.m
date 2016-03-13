% try Kalman filter:

% INPUTS ----------------------------------------

% x(t) :    target location at time t, x is a vector representing all target
%           locations.
% y(t) :    estimated location at time t, y is a vector representing all
%           estimates.
% w(t) :    target noise at time t
% v(t) :    estimation noise at time t
% Q    :    std of the target noise
% R    :    std of the estimation noise

% EXAMPLE ---------------------------------------

exampleOn = 1;
exampleOn = checkExampleOn(exampleOn, mfilename);

if exampleOn
    Q    = 2;
    R    = 1;
    x(1) = 1;
    y(1) = x(1) +randn*R;
    P(1) = R;      % NOT SURE ABOUT THIS
    nTimeStep = 100;
    est(1) = y(1); % NOT SURE ABOUT THIS
end


%%

for t = 2 : nTimeStep
    x(t) = x(t - 1) + randn*Q;
    y(t) = x(t) +randn*R;
    
    S(t) = P(t-1) + Q;
    K(t) = S(t)/(S(t) + R);
    est(t) = est(t - 1) + K(t) * (y(t) - est(t- 1));
    P(t) = K(t) * R;
    
end


%%

figure (1), clf
subplot(2, 3, 1)
plot(x), hold on
plot(y)
plot(est)
legend('target', 'estimate')
title('target and estimate')

subplot(2, 3, 4)
plot(S), title('S')

subplot(2, 3, 5)
plot(P), title('P')

subplot(2, 3, 6)
plot(K), title('K')