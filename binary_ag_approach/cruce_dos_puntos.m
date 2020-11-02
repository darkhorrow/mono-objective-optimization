% ESTA SUBRUTINA REALIZA EL CRUCE EN UN PUNTO DE CADA UNA DE LAS VARIABLES

function [pop] = cruce_dos_puntos(pop)

global N tot_bits pcru

%Ponemos a cero los indicadores de padres cruzados
for i=1:N
    pop(N+i,tot_bits+1) = 0;
end

%Padres que no se cruzan
nclones = N - floor(N*pcru);
if mod(nclones,2) ~= 0
    nclones = nclones+1;
end

for nclon=1:nclones
    ni = randi([N+1 2*N],1,1);
    pop(nclon,1:tot_bits) = pop(ni,1:tot_bits);
end
	
for ni=nclones+1:2:N
    %Seleccionamos aleatoriamente los individuos que se cruzan:
    %nuno se cruzará con ndos
    [nuno] = seleccion_padre(N, pop(N+1:2*N,tot_bits+1));
    [ndos] = seleccion_padre(N, pop(N+1:2*N,tot_bits+1));
    while nuno == ndos
        [nuno] = seleccion_padre(N, pop(N+1:2*N,tot_bits+1));
        [ndos] = seleccion_padre(N, pop(N+1:2*N,tot_bits+1));
    end
    
    %Obtenemos los descendientes
    ptocru1=randi([1 tot_bits],1,1);  %determinar el primer punto de cruce (entre 1 y tot_bits)
    ptocru2=randi([1 tot_bits],1,1);  %determinar el segundo punto de cruce (entre 1 y tot_bits)
    
    if ptocru1>ptocru2
        auxi=ptocru1;
        ptocru1=ptocru2;
        ptocru2=auxi;
    end
        
    for j=1:tot_bits
        if j<=ptocru1
            pop(ni,j)=pop(N+nuno,j);    %descendiente ni
            pop(ni+1,j)=pop(N+ndos,j);  %descendiente ni+1
        end
        if j>ptocru1 && j<=ptocru2
            pop(ni,j)=pop(N+ndos,j);    %descendiente ni
            pop(ni+1,j)=pop(N+nuno,j);  %descendiente ni+1
        end
        if j>ptocru2
            pop(ni,j)=pop(N+nuno,j);    %descendiente ni
            pop(ni+1,j)=pop(N+ndos,j);  %descendiente ni+1
        end
    end
end

end