%Polynomial function_7th degree
x = [0:1:100];
y = 3 * x.^7 - 5 * x.^6 + 12 * x.^5 + 1 * x.^4 + 9 * x.^3 - 39 * x.^2 - 15 * x + 1
plot (x,y,'r-')
title ('7th degree polynomial function')
xlabel ('X')
ylabel ('F(x)')
grid on
hold on

coeff = polyfit(x,y,n)
xfit = linspace(min(x),max(x),100)
yfit = polyval(coeff,xfit)
plot(x,y,'o',xfit,yfit)


