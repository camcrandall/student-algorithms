function pr=prime(a,b)
%prime: finds all prime numbers between two values.
%   given two positive integers in increasing order, finds the prime
%   numbers and displays them in a vector.
a = input('First Number = ');
b = input('Second Number = ');
if b<0||a<0
    error('The input argument must be a positive integer.');
elseif b<a
    error('The value of n must be larger than the value of m.');
end


for j = 0:b-a
    flag = 0;
    for i=2: sqrt(a+j)
        if (mod((a+j),i)==0)
            flag=1;
        end
    end
    if flag==0
        fprintf('%d',a+j)
        fprintf('\n')
    end
end



