% ESTA SUBRUTINA REALIZA LA MUTACIÓN EN UN PUNTO

function [pop] = mutacion_un_punto(pop,N,nvars,nbits)

for i=1:N
    %Comprobamos si el individuo i muta o no
    
    inicio=0;
    for nv=1:nvars
        %Probabilidad de mutacion (1/nbits) (prob. se realice mutación)
        pmut=1/nbits(nv);
        if rand() <= pmut
            npobit=randi([inicio+1 inicio+nbits(nv)],1,1);  %determinamos el bit que muta (entre 1 y nbits(nv)) 
            if pop(i,npobit)==0
                pop(i,npobit)=1;
            else
                pop(i,npobit)=0;
            end
            inicio=inicio+nbits(nv);
        end
    end
end

end