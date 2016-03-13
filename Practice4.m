%Exponential subplots
x = [0:0.01:10];
y = exp(-1.5*x).*sin(10*x);
subplot(1,3,1)
plot(x,y), xlabel('x'),ylabel('exp(?1.5x)*sin(10x)'),axis([0 5 -1 1])
y = exp(-2*x).*sin(10*x);
subplot(1,3,2)
plot(x,y),xlabel('x'),ylabel('exp(?2x)*sin(10x)'),axis([0 5 -1 1])
y = exp(-2.5*x).*sin(10*x);
subplot(1,3,3)
plot(x,y),label('x'),ylabel('exp(-2.5*x).*sin(10*x)'),axis([0 5 -1 1])
hold off





