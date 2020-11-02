function [pop] = seleccion_proporcional(pop)

global nvars N tot_bits

%%%%%%%%%%%%%%%%%%%%%%%%
%SELECCION PROPORCIONAL%
%%%%%%%%%%%%%%%%%%%%%%%%

%Calculamos la suma de todas las funciones objetivo
suma = 0;
for i=1:N
    suma = suma + pop(i,tot_bits+nvars+1);
end

%Calculamos la probabilidad de selección de cada cromosoma y generamos la función de probabilidad
fprob=zeros(1,N);
for i=1:N
    fprob(i) = (1 - (pop(i,tot_bits+nvars+1)/suma))/(N-1);
end

%Creamos la población copia para el cruce (matpool)
ncopias = ceil(N*fprob(1));
numcopias = ncopias;
for j=1:ncopias
    for k=1:1:tot_bits
        pop(N+j,k) = pop(1,k);
    end
end
            
for i=2:1:N
    while numcopias<N
        contador=0;
        for j=1:1:i-1
            for k=1:1:tot_bits
                if pop(i,k)~=pop(j,k)
                    contador = contador+1;
                    break;
                end
            end
        end
        
        if contador==i-1 %Este individuo es distinto de los clonados previamente
            ncopias = ceil(N*fprob(i));
            if numcopias+ncopias > N
                ncopias = N-numcopias;
            end
            
            for j=1:ncopias
                for k=1:tot_bits
                    pop(N+numcopias+j,k) = pop(i,k);
                end 
            end
        end
        
        numcopias = numcopias+ncopias;
    end
end

end