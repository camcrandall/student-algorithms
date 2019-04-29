function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%falsePosition: Given a range, finds a zero within that range.
%   Uses the false position method to locate a root within a given range.
%  inputs:
%   func = function
%   xl,xu = lower and upper guesses, respectively
%   es = stopping criterion (defaults to 0.00001%)
%   maxiter = maximum number of iterations (defaults to 200)
%  outputs:   
%   root = estimate of root
%   fx = function evaluated at estimate of root
%   ea = approximate relative error
%   iter = number of iterations to reach estimate of root

if nargin<3 
    error ('need to define at least 3 input arguments');    %Prompt error if less than 3 inputs are given
end
if func(xl)*func(xu)>0
    error('no sign change detected over given interval');   %Prompt error if no sign change occurs
end
if nargin<4||isempty(es)     %Defaults the stopping criterion to .0001 when no value is given
    es = 0.0001;
end
if nargin<5||isempty(maxiter)      %Defaults the max number of iterations to 200 when no value is given
    maxiter = 200;
end
iter = 0;       %Set iterations as zero before first iteration
xr = xl;        %For the first iteration, in case the code stops, the error will be 100%
ea = 100;
while (1)
    xrold = xr;     %Sets a previous value of xr for calculation of approximate relative error
    xr = xu-(func(xu)*(xl-xu))/(func(xl)-func(xu));          %Calculates a current value of xr
    iter = iter + 1;      %Increase iteration count for each successive loop  
    if xr ~= 0
        ea = abs((xr-xrold)/xr)*100;        %Calculates approximate relative error
    end
    change = func(xl)*func(xr);         %Calculates product of the function evaluated at xl and xr
    if change < 0
        xu = xr;                        %If the product is less than zero, the root occurs over the interval between xl and xr, setting xr as the new xu
    elseif change > 0
        xl = xr;                        %If the product is greater than zero, then the root occurs over the interval between xr and xu, setting xr as the new xl
    else
        ea = 0;                         %Otherwise the approximate error is zero and xr is equal to the root, within machine epsilon
    end
    if ea <= es
        break                           %Breaks when the approximate relative error is less than the stopping criterion
    elseif iter >= maxiter
        break
    end
root = xr;                              %Assigns xr as the root value and assigns f(xr)
fx = func(xr);
end

