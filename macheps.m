mu = .55;
m = 25;
g = 9.81;
bananas = @(x) mu*m*g/(cos(x)+mu*sin(x))-150;
[root,fx,ea,iter]=falsePosition(bananas,-2,2);
    
fplot(bananas);