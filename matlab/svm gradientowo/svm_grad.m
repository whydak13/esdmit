function [ w, output, value, error, cost ] = svm_grad( X,y, w0 ,C,max_it,eps)
%SVM_GRAD gradient linear svm training algoritm for non-separable data
%% OUTPUTS
% w - found vector [w1..wm b]
% value = w(1:m)'*X+b - training data values
% output = sign(value) - training data classyfication 
% error= difference between classyfications and labels
% cost - vector of cost in each iteration
%% INPUTS
% X - training data, [N,m]- m-number of dimensions, N- number of data
% points
% y - training data clasyfication
% w0 - starting vector. Wise pdf says its convex problem so who cares.
% C, max_it, eps - params described in main

    w=w0;
    [N,m]=size(X);
    lam=2/(N*C);
    cost=[];
    for i=1:max_it
         ni=1/(lam*i);   %lerning factor
         i_cost=cost_fun( X,y, w,C );
         cost=  [ cost i_cost]; % can be removed, displays cost function and slows down everything
         if i_cost<=eps
             break
         end
         w_grad=gradient( X,y, w,C );
         w=w-ni*w_grad;

    end

    value=X*w(1:end-1)+w(end);
    output=sign(value);
    error=abs(y-output)/2;
end

