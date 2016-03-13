%% 9) Plot the functions x, x3, ex and ex2 over the interval 0 < x < 4 ...
%(a) on rectangular paper
%(b) on semilog paper (logarithm on the y-axis)
%(c) on log-log paper

%x = [1 2 3 4 5 6 7 8 9 10];
x = [0:0.01:2];
y1 = x.^3;
y2 = exp(x);
y3 = y2.^2;

figure (4), clf
subplot(2, 2, 1)
semilogx(x, y1,'b.-')
hold on

title ('Parabolic curve')
xlabel ('X')
ylabel ('X^2')
grid on

subplot(2, 2, 2)
semilogy(x, y2, '.-')
grid on,

subplot(2, 2, 3)
plot(x, y3),
grid on








%% Polynomial functions_4thdegree
a = [0:1:10];
b = 3*a.^4 + 2 * a.^3 + 7 * a.^2 + 2 * a + 9 + randn(1, length(a))*1000;

b = rand(1, length(a));
figure (5), clf
subplot(1, 3, 1)
plot(a, b, 'b.-')
grid on
title ('Fourth degree polynomial function')
xlabel ('A')
ylabel ('F(a)')
hold off



for degree = 1: 20
    coeff = polyfit(a, b, degree);
    yfit = polyval(coeff, a);
    
    diff(degree) = sum((b-yfit).^2);
    
    subplot(1, 3, 2)
    plot(a, yfit, '.-', 'markerSize', 10), hold on,
    if degree == 12
         plot(a, yfit, '.-', 'markerSize', 10, 'lineWidth', 6), hold on,
    end
    grid on
end

subplot(1, 3, 2)
title('different degree of polynomial fit')

subplot(1, 3, 3)
plot(1:20, diff, '.-','markerSize', 30), hold on

xlabel('polynomial degree'), 
ylabel('error size')
title('error size'),  grid on
%ylim([0, 10^7])
% >> coeff = polyfit(a,b,1)
% coeff =
%  1.0e+03 *
% 2.6539   -6.5073

% >> slope = coeff(1)
%2.6539e+03

% >> intercept = coeff(2)
%  -6.5073e+03





