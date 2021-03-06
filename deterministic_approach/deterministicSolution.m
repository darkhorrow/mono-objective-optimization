clc   % Clear Command Window.
clear % Clear variables and functions from memory.

% x1 = ts; x2 = th; x3 = R; x(4) = L;

x0 = [0.0625,0.0625,10,10];         % Initial conditions with lower bounds
solve(x0);

x0 = [0.0625*99,0.0625*99,200,240]; % Initial conditions with upper bounds
solve(x0);

x0 = [0.0625*50,0.0625*50,100,120]; 	% Initial conditions with (almost) upper bound / 2 
solve(x0);

function [] = solve(initialPoint)


    LB = [0.0625,0.0625,10,10]; % Lower bounds
    UB = [0.0625*99,0.0625*99,200,240]; % Upper bounds
    A = [-1,0,0.0193,0; 0,-1,0.00954,0; 0,0,0,0; 0,0,0,0]; %A
    b = [0;0;0;0]; %b

    disp('Running...')

    % Modificamos algunas de las opciones de OPTIMSET
    options = optimset('Algorithm','interior-point',...
        'TolFun',1.e-10, 'TolCon',1.e-20,'PlotFcns','optimplotfval',...
        'TolX', 1.e-14);

    [x,fval,exitflag,output] = fmincon(@objectiveFunction,...
        initialPoint,A,b,[],[],LB,UB,@nonlinearconst,options);

    % ts y th deben ser múltiplos de 0.0625
    for i=1:2
        s = round(x(i)/0.0625);
        x(i) = 0.0625*s;
    end
    
    for i=1:4
        x(i) = round(x(i), 4);
    end
    
    fprintf('El punto inicial es: [');
    fprintf('%g ', initialPoint);
    fprintf(']\n');
    fprintf('\nLa función alcanza el mínimo en fval=%f \n',objectiveFunction(x));
    fprintf('TS = %10.4f \n', x(1));
    fprintf('TH = %10.4f \n', x(2));
    fprintf('R = %10.4f \n', x(3));
    fprintf('L = %10.4f \n', x(4));
    fprintf('ts/R = %10.4f \n', x(1)/x(3));
    fprintf('th/R = %10.4f \n', x(2)/x(3));
    fprintf('V = %10.4f \n', pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3);
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

end
