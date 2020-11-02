function [mejor,fmejor,fpop]=GA(jj,ensayos)

global N E G tipo_seleccion tipo_cruce tipo_mutacion ...
    nvars nbits tot_bits ngendibujo

%dimensionamiento de la matriz de trabajo
pop=zeros(2*N,tot_bits+nvars+1); %matriz población con nº filas(cromosomas) = 2*N  
                                 %nº de columnas = tot_bits, además se incluyen nvars+1 columnas:
                                 %valor x --> pop(i,tot_bits+1:tot_bits+nvars)
                                 %valor y=f(x) --> pop(i,tot_bits+nvars+1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  % G=0 SE GENERA POBLACION INICIAL DE PADRES DE TAMAÑO N 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      
for ni=1:N  %ni=número individuo por el que se va
    [pop]=generar_poblacion_ley_uniforme(pop,ni,tot_bits);
    [pop]=fitness_function(pop,ni); 
end
%se ordena de MENOR a MAYOR por f(x)(MINIMIZA) y los elitistas quedan arriba
pop(1:N,:)=sortrows(pop(1:N,:),tot_bits+nvars+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                             % G>0 COMIENZA EL ALGORITMO 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
for generacion=1:G
    %Seleccion: este proceso parte de los individuos de pop(1:N),
    %           realiza la selección y deposita la copia 
    %           de los individuos seleccionados en pop(N+1:2*N)
    switch tipo_seleccion
        case 0
            [pop] = seleccion_proporcional(pop);
        case 1
            [pop] = torneo_probabilistico(pop);
        case 2
            [pop] = torneo(pop);
        otherwise
            disp('ERROR-al elegir el operador de selección');
    end
    
    %Cruce: este proceso parte de los individuos de copia,
    %           los cruza y deposita los nuevos individuos en pop 
    switch tipo_cruce
        case 0
            [pop] = cruce_un_punto(pop);
        case 1
            [pop] = cruce_dos_puntos(pop);
        case 2
            [pop] = cruce_uniforme(pop);
        otherwise
            disp('ERROR-al elegir el operador de cruce');
    end
    
    %Mutación: este proceso muta los individuos de pop
    switch tipo_mutacion
        case 0
            [pop] = mutacion_un_punto(pop,N,nvars,nbits);
        case 1
            [pop] = mutacion_dos_puntos(pop,N,nvars,nbits);
        case 2
            [pop] = mutacion_uniforme(pop,N,nvars,nbits);
        otherwise
            disp('ERROR-al elegir el operador de mutación');
    end
    
    %Evaluación de la función de aptitud
    for ni=N+1:2*N
        [pop]=fitness_function(pop,ni);
    end
    
    %actualización de la población: copia de los descendientes en población
    %se copia a partir de E+1 para mantener elitistas
    pop(E+1:N+E,:)=pop(N+1:2*N,:); 
    %ordena MENOR a MAYOR por f(x)(MINIMIZA) hasta N+E y elite quedan arriba
    pop(1:N+E,:)=sortrows(pop(1:N+E,:),tot_bits+nvars+1);
  
    %muestra evolución tiempo y dibuja gráfica y soluciones por generación
    if ensayos == 1 && (generacion == 1 || mod(generacion,ngendibujo) == 0)
        dibuja_fmejor(G,generacion,pop(1,tot_bits+nvars+1));
        pause(0.1);
    end
    
    %muestra porcentajes de tiempos
    %muestra_evolucion_tiempo(G,generacion,jj);     
    
end %FIN for generacion=1:G

mejor=pop(1,tot_bits+1:tot_bits+nvars);
fmejor=pop(1,tot_bits+nvars+1);
fpop=pop(:,tot_bits+nvars+1);

end
