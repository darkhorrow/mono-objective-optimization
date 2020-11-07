clc   % Clear Command Window.
clear % Clear variables and functions from memory.

% x1 = ts; x2 = th; x3 = R; x(4) = L;

iter = 30;

solutions_07 = [];
solutions_08 = [];
solutions_09 = [];

for iter = 1:iter
   solutions_07  =  [solutions_07;objectiveFunction(solve(0.7))]; 
   solutions_08  =  [solutions_08;objectiveFunction(solve(0.8))];
   solutions_09  =  [solutions_09;objectiveFunction(solve(0.9))];
end

printData(solutions_07, 'Con 0.7 de probabilidad de cruze');
printData(solutions_08, 'Con 0.8 de probabilidad de cruze');
printData(solutions_09, 'Con 0.9 de probabilidad de cruze');

function [value] = solve(crossfrac)


    LB = [0.0625,0.0625,10,10]; % Lower bounds
    UB = [0.0625*99,0.0625*99,200,240]; % Upper bounds
    A = [-1,0,0.0193,0; 0,-1,0.00954,0; 0,0,0,0; 0,0,0,0]; %A
    b = [0;0;0;0]; %b

    fprintf('\nRunning with croosover probability = %f...\n', crossfrac);

    % Modificamos algunas de las opciones de OPTIMSET
    options = optimoptions('ga', 'PopulationSize', 100, 'Generations', 150,...
        'EliteCount', 1, 'SelectionFcn', 'selectionstochunif',... 
        'CrossoverFcn', 'crossoverarithmetic',... 
        'CrossoverFraction', crossfrac,...
        'MutationFcn','mutationadaptfeasible',...
        'TolCon',1.e-20);
       
   
    [x,fval,exitflag,output] = ga(@objectiveFunction,...
        4,A,b,[],[],LB,UB,@nonlinearconst,options);

    % ts y th deben ser múltiplos de 0.0625
    for i=1:2
        s = round(x(i)/0.0625);
        x(i) = 0.0625*s;
    end
    
    value = x;
    
%     fprintf('\nLa función alcanza el mínimo en fval=%f \n',objectiveFunction(x));
%     fprintf('TS = %f \n', x(1));
%     fprintf('TH = %f \n', x(2));
%     fprintf('R = %f \n', x(3));
%     fprintf('L = %f \n', x(4));
%     fprintf('ts/R = %f \n', x(1)/x(3));
%     fprintf('th/R = %f \n', x(2)/x(3));
%     fprintf('V = %f \n', pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3);
%     fprintf('El valor de la variable EXITFLAG es %d \n',exitflag);

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

function [] = printData(data, title)
    fprintf(title);
    fprintf('\nEl valor total de la media es %f \n',mean(data));
    fprintf('\nEl valor total de la std es %f \n',std(data));
    fprintf('\nEl mejor valor es %f \n',max(data));
end
