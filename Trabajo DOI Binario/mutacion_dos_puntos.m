% ESTA SUBRUTINA REALIZA LA MUTACIÓN EN UN PUNTO

function [pop] = mutacion_dos_puntos(pop,N,nvars,nbits)

for i=1:N
    %Comprobamos si el individuo i muta o no
    
    inicio=0;
    for nv=1:nvars
        %Probabilidad de mutacion (1/nbits) (prob. se realice mutación)
        pmut=1/nbits(nv);
        if rand() <= pmut
            npobit1=0;
            npobit2=0;
            while npobit1==npobit2      %generamos dos numeros distintos entre 1 y nbits(nv)
                npobit1=randi([inicio+1 inicio+nbits(nv)],1,1);  %determinamos el primer bit que muta (entre 1 y nbits(nv)) 
                npobit2=randi([inicio+1 inicio+nbits(nv)],1,1);  %determinamos el segundo bit que muta (entre 1 y nbits(nv)) 
            end
            
            %Intercambiamos los bits seleccionados
            copia=pop(i,npobit1);
            pop(i,npobit1)=pop(i,npobit2);
            pop(i,npobit2)=copia;
            
            inicio=inicio+nbits(nv);
        end
    end
end

end