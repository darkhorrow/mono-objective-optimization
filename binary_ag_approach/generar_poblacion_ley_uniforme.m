%FUNCION GENERA POBLACION INICIAL POR LEY UNIFORME
function pop = generar_poblacion_ley_uniforme(pop,ni,tot_bits)

global nvars

while 1
    
    individuo = zeros(1,tot_bits+nvars+1);

    %Inicialmente pop es una matriz de ceros
    for j=1:1:tot_bits
        if rand()>=0.5 %genera número aleatorio entre [0,1]
            individuo(j) = 1;
        end
    end
    
    if basic_fitness_function(individuo)
        pop(ni,:) = individuo;
        break;        
    end
    
end

end