%Polynomial subfunctions
x = [0:0.01:10];
y = 2*x.^0.5
subplot (1,4,1)
plot(x,y), xlabel('x'),ylabel('2*x.^0.5')
y = 2*x
subplot (1,4,2)
plot(x,y), xlabel('x'),ylabel('2*x')
y = 2*x.^1.5
subplot (1,4,3)
plot(x,y), xlabel('x'),ylabel('2*x.^1.5')
y = 2* x.^2
subplot (1,4,4)
plot(x,y), xlabel('x'),ylable('2* x.^2')