function [pop]=torneo_probabilistico(pop)

global psel nvars N tot_bits

for i=1:1:N
    %Elegimos a los candidatos
    nsuno=0;
    nsdos=0;
    while nsuno==nsdos      %generamos dos numeros distintos entre 1 y N
        nsuno=randi([1 N],1,1);
        nsdos=randi([1 N],1,1);
    end
    
    %Torneo 2:1 entre nsuno y nsdos para escoger un padre
    if rand()<=psel 
        if pop(nsuno,tot_bits+nvars+1)<=pop(nsdos,tot_bits+nvars+1)   %MINIMIZA
            pop(N+i,1:tot_bits)=pop(nsuno,1:tot_bits);
        else
            pop(N+i,1:tot_bits)=pop(nsdos,1:tot_bits);
        end
    else
        if pop(nsuno,tot_bits+nvars+1)>=pop(nsdos,tot_bits+nvars+1)   %MAXIMIZA
            pop(N+i,1:tot_bits)=pop(nsuno,1:tot_bits);
        else
            pop(N+i,1:tot_bits)=pop(nsdos,1:tot_bits);
        end        
    end
end

end