%FUNCION CALCULA LOS VALORES DE LAS FUNCIONES OBJETIVO
function pop = fitness_function(pop,ni)

global nvars tot_bits

%vector que guarda los valores de variables en decimal
x = bin2real(pop(ni,:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%APLICAMOS formula para calcular f(x) (se guarda en columna tot_bits+nvariables+1) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:nvars
    %valor de xj (columna tot_bits+j)   
    pop(ni,tot_bits+j)=x(j);   
end

% x1 = ts; x2 = th; x3 = R; x(4) = L
coste = 0.6224*x(1)*x(3)*x(4) + 1.7781*x(2)*x(3)^2 + 3.1661*x(1)^2*x(4) + 19.86*x(1)^2*x(3);

% Restricciones lineales:
con1 = -x(1) + 0.0193 * x(3);
con2 = -x(2) + 0.00954 * x(3);

% Restricción no lineal:
con3 = -(pi*x(3)^2*x(4)+(4/3)*pi*x(3)^3) + 750*12^3;

% Función de aptitud (Fitness Function)
coste_total = coste;

if con1 > 0
    coste_total = coste_total + (1.e6 * (con1)^2);
end

if con2 > 0
    coste_total = coste_total + (1.e6 * (con2)^2);
end

if con3 > 0
    coste_total = coste_total + (1.e6 * (con3)^2);
end

pop(ni,tot_bits+nvars+1) = coste_total;

end  