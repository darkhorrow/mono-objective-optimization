%FUNCION CALCULA LOS VALORES DE LAS FUNCIONES OBJETIVO
function feasible = basic_fitness_function(individuo)

%vector que guarda los valores de variables en decimal
x=bin2real(individuo);

% Restricciones lineales:
con1 = -x(1) + 0.0193 * x(3);
con2 = -x(2) + 0.00954 * x(3);

% Restricción no lineal:
con3 = -(pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3) + 750*12^3;

feasible = 1;

if con1 > 0
    feasible = 0;
end

if con2 > 0
    feasible = 0;
end

if con3 > 0
    feasible = 0;
end

end 