function [Z,E] = solve_lrr(X,lambda)
Q = orth(X');
A = X*Q;
[Z,E] = inexact_alm_lrr(X,A,lambda);
Z = Q*Z;
