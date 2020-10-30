function [f] = objectiveFunction(x)

% x1 = ts; x2 = th; x3 = R; x(4) = L

f = 0.6224*x(1)*x(3)*x(4) + 1.7781*x(2)*x(3)^2 + 3.1661*x(1)^2*x(4) + 19.86*x(1)^2*x(3);

end