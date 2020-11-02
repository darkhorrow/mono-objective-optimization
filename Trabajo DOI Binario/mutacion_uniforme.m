% ESTA SUBRUTINA REALIZA LA MUTACIÓN EN UN PUNTO

function [pop] = mutacion_uniforme(pop,N,nvars,nbits)

for i=1:N
    %Comprobamos si el individuo i muta o no
    
    inicio=0;
    for nv=1:nvars
        %Probabilidad de mutacion (1/nbits) (prob. se realice mutación)
        pmut=1/nbits(nv);
        for npobit=inicio+1:1:inicio+nbits(nv)
            if rand() <= pmut
                if pop(i,npobit)==0
                    pop(i,npobit)=1;
                else
                    pop(i,npobit)=0;
                end
            end
        end
        inicio=inicio+nbits(nv);
    end
end

end