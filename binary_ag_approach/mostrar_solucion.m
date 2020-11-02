function mostrar_solucion(x)

global nvars

% Función objetivo
coste = 0.6224*x(1)*x(3)*x(4) + 1.7781*x(2)*x(3)^2 + 3.1661*x(1)^2*x(4) + 19.86*x(1)^2*x(3);

% Restricciones lineales:
con1 = -x(1) + 0.0193 * x(3);
con2 = -x(2) + 0.00954 * x(3);

% Restricción no lineal:
con3 = -(pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3) + 750*12^3;

% Función de aptitud (Fitness Function)
coste_total = coste;

if con1 > 0
    coste_total = coste_total + 1.e6*(con1)^2;
end

if con2 > 0
    coste_total = coste_total + 1.e6*(con2)^2;
end

if con3 > 0
    coste_total = coste_total + 1.e6*(con3)^2;
end

fprintf('     TS         TH         R         L\n');

for j=1:nvars
    fprintf('%10.3f ',x(j));
end

fprintf('\n\n');

fprintf('Coste total: %10.3f\n', coste_total);
fprintf('Volumen óptimo: %10.3f\n',pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3);

end