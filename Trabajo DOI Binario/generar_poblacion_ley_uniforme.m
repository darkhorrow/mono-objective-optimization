%FUNCION GENERA POBLACION INICIAL POR LEY UNIFORME
function [pop]=generar_poblacion_ley_uniforme(pop,ni,tot_bits)

%Inicialmente pop es una matriz de ceros
for j=1:1:tot_bits
    if rand()>=0.5 %genera número aleatorio entre [0,1]
        pop(ni,j)=1;
    end
end

end