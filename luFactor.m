function [L,U,P] = luFactor(A)
%luFactor: Given an nxn matrix A, determines LU factorization for the
%matrix and a pivot matrix.
%  luFactor decomposes a given matrix A into a lower triangular matrix L that stores values used in
%  the forward elimination step of gaussian elimination. It also creates a
%  matrix U, which corresponds to coefficients of variables after
%  completing the gaussian elimination. The final output P is a vector
%  which contains values corresponding to the rows switched during gaussian
%  elimination to prevent division by zero and to minimize subtractive
%  cancellation errors.
%
%  A = A square matrix.
%
%    

%Check dimension of input matrix
[m n] = size(A);
if m~=n;
    error('Dimension of A must be square!');
end
%Save a copy of A so that original A is preserved
Asub = A;
n = size(A);
%Set up L and P
L=eye(n);
P = eye(n);

%Determine the row at which the pivot has greatest absolute value, moves
%diagonally down the matrix after each successive step of gaussian
%elimination. 
for k=1:n-1
    [maxval,loc] = max(abs(Asub(k:n,k)));
    switched = k-1+loc;
    %Switches rows after each successive iteration of gaussian elimination.
    %Correspondingly modifies P.
    Asub([switched,k],:) = Asub([k,switched],:);
    P([switched,k],:) = P([k,switched],:);
    %Gaussian Elimination
    for i=k+1:n
        L(i,k)=Asub(i,k)/Asub(k,k);     %L21=A21/A11, L22=A'32/A'22, etc. 
        Asub(i,k:n)= Asub(i,k:n)-L(i,k)*Asub(k,k:n);    %Subtracts rows from rows after multiplication by corresponding value of L
    end
end
%Probably not necessary to save original A, but just in case
U = Asub;
end

