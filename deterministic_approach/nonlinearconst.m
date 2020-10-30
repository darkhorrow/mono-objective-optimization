function [c, ceq] = nonlinearconst(x)

% x1 = ts; x2 = th; x3 = R; x(4) = L; x5 = k;

c = -(pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3) + 750*12^3;

ceq = 0;

end