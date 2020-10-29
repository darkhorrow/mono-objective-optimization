clc   % Clear Command Window.
clear % Clear variables and functions from memory.

% x1 = ts; x2 = th; x3 = R; x(4) = L;

x0 = [1,1,1,1]; 	% Initial conditions 
LB = [0.0625,0.0625,10,10]; % Lower bounds
UB = [0.0625*99,0.0625*99,200,240]; % Upper bounds
A = [-1,0,0.0193,0; 0,-1,0.00954,0; 0,0,0,0; 0,0,0,0]; %A
b = [0;0;0;0]; %b

disp('Running...')

% Modificamos algunas de las opciones de OPTIMSET
options = optimset('Algorithm','sqp',...
    'TolFun',1.e-10, 'TolCon',1.e-20,'PlotFcns','optimplotfval');

[x,fval,exitflag,output] = fmincon(@C,x0,A,b,[],[],LB,UB,@nonlinearconst,options);

% ts y th deben ser múltiplos de 0.0625
for i=1:2
    s = round(x(i)/0.0625);
    x(i) = 0.0625*s;
end

fprintf('\nLa función alcanza el mínimo en fval=%f \n', C(x));
fprintf('TS = %f \n', x(1));
fprintf('TH = %f \n', x(2));
fprintf('R = %f \n', x(3));
fprintf('L = %f \n', x(4));
fprintf('ts/R = %f \n', x(1)/x(3));
fprintf('th/R = %f \n', x(2)/x(3));
fprintf('V = %f \n', pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3);
fprintf('El valor de la variable EXITFLAG es %d \n',exitflag);

% disp(' ');
% str = sprintf('Algoritmo utilizado: %s',output.algorithm);
% disp(str);
% str = sprintf('Número de iteraciones del algoritmo: %d',output.iterations);
% disp(str);
% str = sprintf('Número de evaluaciones de la función: %d',output.funcCount);
% disp(str);
% str = sprintf('%s',output.message);
% disp(str);

% Possible values of EXITFLAG and the corresponding exit conditions:  
%     All algorithms:
%       1  First order optimality conditions satisfied.
%       0  Too many function evaluations or iterations.
%      -1  Stopped by output/plot function.
%      -2  No feasible point found.
%     Trust-region-reflective and interior-point:
%       2  Change in X too small.
%     Trust-region-reflective:
%       3  Change in objective function too small.
%     Active-set only:
%       4  Computed search direction too small.
%       5  Predicted change in objective function too small.
%     Interior-point:
%      -3  Problem seems unbounded.