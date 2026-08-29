clc;
clear;
close all;

% Joint probability matrix P(X,Y)
% Rows represent X and columns represent Y
Pxy = [0.1  0.2;
    0.2  0.5];

% Check whether probabilities sum to 1
if abs(sum(Pxy(:)) - 1) > 1e-10
    error('Joint probability matrix must sum to 1.');
end

% Marginal probabilities
Px = sum(Pxy, 2);       % P(X)
Py = sum(Pxy, 1);       % P(Y)

% Joint Entropy H(X,Y)
Hxy = 0;
for i = 1:length(Px)
    for j = 1:length(Py)
        if Pxy(i,j) > 0
            Hxy = Hxy - Pxy(i,j) * log2(Pxy(i,j));
        end
    end
end

% Entropy of X: H(X)
Hx = 0;
for i = 1:length(Px)
    if Px(i) > 0
        Hx = Hx - Px(i) * log2(Px(i));
    end
end

% Entropy of Y: H(Y)
Hy = 0;
for j = 1:length(Py)
    if Py(j) > 0
        Hy = Hy - Py(j) * log2(Py(j));
    end
end

% Conditional Entropy
H_Y_given_X = Hxy - Hx;    % H(Y|X)
H_X_given_Y = Hxy - Hy;    % H(X|Y)

% Mutual Information
Ixy = Hx + Hy - Hxy;

% Display results
fprintf('Entropy H(X)       = %.4f bits\n', Hx);
fprintf('Entropy H(Y)       = %.4f bits\n', Hy);
fprintf('Joint Entropy H(X,Y) = %.4f bits\n', Hxy);
fprintf('Conditional Entropy H(Y|X) = %.4f bits\n', H_Y_given_X);
fprintf('Conditional Entropy H(X|Y) = %.4f bits\n', H_X_given_Y);
fprintf('Mutual Information I(X;Y) = %.4f bits\n', Ixy);
