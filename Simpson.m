function [I] = Simpson(x,y)
%UNTITLED Computes a numerical estimate of an integral
%   Given a set of data (y) over a regular interval (x), computes an
%   estimate using simpson's 1/3 rule, or if the number of intervals is
%   odd, uses a trapezoidal estimation for the last interval.
m = length(x);
n = length(y);
%Check if dimensions of x and y vectors agree
if m ~= n
    error('x and y vectors must be the same length');
end
%Check if the given x vector is regularly spaced
spacing = linspace(x(1),x(m),m);
checkers = isequal(spacing,x);
if checkers ~= 1
    error('x is not evenly spaced! Try linspace.')
end
%If the number of intervals is even, then simpson's 1/3 is applied
if mod((m-1),2)==0
    odds = sum(y(1:2:n-1));
    evens = sum(y(2:2:n-1));
    I = (x(m)-x(1))*((y(1)+4.*odds+2.*evens+y(n))/(3.*(m-1)));
%if the number of intervals is odd, then a trapezoidal estimation is used
%for the last interval
else
    odds = sum(y(1:2:n-2));
    evens = sum(y(2:2:n-2));
    I = (x(m-1)-x(1))*((y(1)+4*odds+2*evens+y(n-1))/(3*(m-1)))+(x(m)-x(m-1))*((y(n)+y(n-1))/2);
    disp('Odd number of intervals, trapezoidal rule used for integral over last inverval');    
    %A warning notifies the user of use of the trapezoidal rule
end
end

