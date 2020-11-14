function [coste_total, volumen, factible, x] = evalua_solucion(x)

x(1) = filtra_valor_valido(x(1), 0.0625);
x(2) = filtra_valor_valido(x(2), 0.0625);

% Función objetivo
coste = 0.6224*x(1)*x(3)*x(4) + 1.7781*x(2)*x(3)^2 + 3.1661*x(1)^2*x(4) + 19.86*x(1)^2*x(3);

% Restricciones lineales:
con1 = -x(1) + 0.0193 * x(3);
con2 = -x(2) + 0.00954 * x(3);

% Restricción no lineal:
con3 = -(pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3) + 750*12^3;

% Función de aptitud (Fitness Function)
coste_total = coste;
factible = 1;

if con1 > 0
    coste_total = coste_total + (1.e6 * (con1)^2);
    factible = 0;
end

if con2 > 0
    coste_total = coste_total + (1.e6 * (con2)^2);
    factible = 0;
end

if con3 > 0
    coste_total = coste_total + (1.e6 * (con3)^2);
    factible = 0;
end

volumen = pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3;

end