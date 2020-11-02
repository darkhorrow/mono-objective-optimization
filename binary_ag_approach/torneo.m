%FUNCION QUE REALIZA LA SELECCION POR TORNEO DE 2, 3 Ó 5
%INDIVIDUOS. NUINTOR ES EL NUMERO DE INDIVIDUOS QUE INTERVIENEN
%EN EL TORNEO. SI NUINTOR=2 O NUINTOR=3, SE ELIGE EL MEJOR, SI
%NUINTOR=5 SE ELIGEN LOS DOS MEJORES.
%LOS INDIVIDUOS SELECCIONADOS SE ALMACENAN EN POP(NINDG+1:2*NINDG)

function [pop] = torneo(pop)

global nuintor nvars N tot_bits

nindex = zeros(1,nuintor);

%Comenzamos con el torneo
if nuintor == 5
    nmax = 2;
else
    nmax = 1;
end

for i=1:nmax:N
    %Elegimos a los candidatos
    for k=1:1:nuintor
        nindex(1,k) = randi([1 N],1,1);  %selecciona un individuo (entre 1 y N)
    end
    
    %Ordenamos los índices de los competidores de menor a mayor
    for k=1:1:nuintor
        nsuno=nindex(1,k);
        for j=(k+1):1:nuintor
            nsdos=nindex(j);
            if pop(nsuno,tot_bits+nvars+1)<=pop(nsdos,tot_bits+nvars+1) %MINIMIZA
                nmin = nindex(1,k);
                nindex(1,k) = nindex(1,j);
                nindex(1,j) = nmin;
            end
        end
    end
    
	%Nos quedamos con el mejor individuo entre los candidatos.
    %Es decir, el de menor índice
    pop(N+i,1:tot_bits) = pop(nindex(1,1),1:tot_bits);
    
    if nuintor == 5
        %Nos quedamos también con el segundo mejor individuo entre los candidatos.
        pop(N+i+1,1:tot_bits) = pop(nindex(1,2),1:tot_bits);
    end
end

end