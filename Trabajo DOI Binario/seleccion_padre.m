function [candidato] = seleccion_padre(nindg, marca)

nintentos = 10;

caso = 1;
while caso == 1
    %Seleccionamos a un padre para el cruce
    ndic=0;
    while caso == 1
        candidato = randi([1 nindg],1,1);  %determinarel candidato (entre 1 y nindg)
        if marca(candidato) == 1
            ndic = ndic+1;
            if ndic > nintentos
                caso = 0;
            end
        else
            caso=0;
        end
    end
    
end