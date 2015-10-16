%% Practice1
x = linspace(0, 5, 1000);
y = sin (x);

xi = linspace (min(x), max(x), 5)'
yi = spline(x,y,xi);
figure (1), clf
subplot(1, 2, 1)
plot(x,y,'.-'), grid on, hold on
plot(xi, yi, '.-', 'lineWidth', 3)
ylim([-1, 1])

subplot(1, 2, 2)
plot(xi, yi, '.-', 'markerSize', 45)
ylim([-1, 1])

xlabel('x'), ylabel('sin(x)')
title('sin(x) (trying out plotting tools)')

% change font size
set(gca, 'fontSize', 20)

% add grid
grid on

% change x grid space/ x tick points:

%set(gca, 'XTick', 0:50:100, 'XTickLabel', {'v1', 'v2', 'v3'})

% subplot(1, 3, 3)
% diff = yi' - y;
% plot(diff), 
%% sampling a square wave

% Question : why the square wave becomes a straight line at -1 when the
% duty cycle is less than around 15?

figure (2), clf
subplot(1, 3, 1)
xValue = 1 : 0.01:5;
squareWave = square(xValue, 50);
plot(xValue, squareWave, 'lineWidth', 3)

samples        = squareWave(1:50:end);
subplot(1, 3, 2)
plot(xValue(1:50:end), samples, '.-', 'markerSize', 25)
title('sampling square wave')

subplot(1, 3, 3)
plot(xValue, squareWave, 'lineWidth', 3), hold on
plot(xValue(1:50:end), samples, '.-', 'markerSize', 25)

%% Practice2
a = 0:pi/10:2*pi;
b = sin(a);
figure (3), clf

plot(a,b,'.-', 'markerSize', 10)
xlabel('a')
ylabel('sin(a)')
title('Plot of the Sine Function')


%% Basic Syntax and Command-line exercises
%1) Create a vector even whole numbers between 31 and 75
x = 31:2:75

%% 2) 
x = 1:1:25;
y = x.^3;
%(a) Add 16 to each element
%(b) Add 3 to just the odd-index elements --> 1st and 3rd element;
%(c) Compute the square root of each element
% d) Compute the square of each element 
samplingGap = 0.01;


a = y + 1600;
b = y(1:samplingGap:end) + 3000;
c = sqrt(y) ;
d = y.^2 ;



figure (4), clf, 
plot(x, y,'.-', 'markerSize', 20), hold on
plot(x, a,'.-', 'markerSize', 20)
plot(1:samplingGap:25, b, '.-', 'markerSize', 20)

%% 3)
x = [3 2 6 8]' 
y = [4 1 3 5]'
%(a) Add the sum of the elements in x to y; sum is a column-oriented syntax
%(b) Raise each element of x to the power specified by the corresponding element in y.
%(c) Divide each element of y by the corresponding element in x
%(d) Multiply each element in x by the corresponding element in y, calling the result "z".
%(e) Add up the elements in z and assign the result to a variable called "w".
%(f) Compute x'*y - w and interpret the result

a = sum (x) + y
b = x.^y
c = y./x
z = x.*y
w = sum (z) 
f = x'*y - w

%% 4) Evaluate the following MATLAB expressions by hand and use MATLAB to check the answers
%(a) 2 / 2 * 3 = 3
%(b) 6 - 2 / 5 + 7 ^ 2 - 1 = 6-(2/5)+49-1= 6-(0.4)+48= 53.6
%(c) 10 / 2 \ 5 - 3 + 2 * 4= 1-3+8=6
%(d) 3 ^ 2 / 4=9/4
%(e) 3 ^ 2 ^ 2=81
%(f) 2 + round(6 / 9 + 3 * 2) / 2 - 3 = 2.33333
%(g) 2 + floor(6 / 9 + 3 * 2) / 2 - 3 = closest minimum integer value
%(h) 2 + ceil(6 / 9 + 3 * 2) / 2 - 3 = closest maximum 0.5 increments


%% 5) Create a vector x with the elements ...
%(a) 2, 4, 6, 8, ...
%(b) 10, 8, 6, 4, 2, 0, -2, -4
%(c) 1, 1/2, 1/3, 1/4, 1/5, ...
%(d)  0, 1/2, 2/3, 3/4, 4/5, ... 
a = 2:2:40
b = 10:-2:-4
c1 = 1:5, c2 = 1./c1 , rats(c2)
d1 = 1:5, d2 =0:4, d3 = d2./d1, rats(d3)
%Don't forget to place '.' after certain value to apply to each element

%% 6) Create a vector x with the elements,
%x_n = (-1)n+1/(2n-1)
%Add up the elements of the version of this vector that has 100 elements.

n = 1:100
x = ( (-1).^(n+1) ) ./ (2*n - 1);
y = sum(x)


%% 7) Write down the MATLAB expression(s) that will
%(a)compute the length of the hypotenuse of a right triangle given the lengths of the sides 
%(try to do this for a vector of side-length values).
     
%(b) compute the length of the third side of a triangle given the lengths of the other two sides, 
%given the cosine rule
% c^2 = a^2 + b^2 - 2(a)(b)cos(t)
% where t is the included angle between the given sides.

%(a)
a = [1:3]
b = [2:4]
x = a.^2 + b.^2
c = sqrt (x)

%(b)
a = [1:3];
b = [2:4];
t = pi;
x = a.^2 + b.^2 - 2*a.*b.*cos(t);
c = sqrt (x)


%% 8) Given a vector, t, of length n, write down the MATLAB expressions 
% that will correctly compute the following:

%(a) ln(2 + t + t2)
%(b) e^t(1 + cos(3t))
%(c) cos2(t) + sin2(t)
%(d) tan-1(1)  (this is the inverse tangent function)
%(e) cot(t)
%(f) sec2(t) + cot(t) - 1
% Test that your solution works for t = 1:0.2:2 

t = 1:0.2:2
a = log(2 + t + t.^2)
b = exp(t).*(1+cos(3*t))
c = cos(t).^2 + sin(t).^2
d = atan(t)
e = cot(t)
f = sec(t).^2 + cot(t) - 1
    


