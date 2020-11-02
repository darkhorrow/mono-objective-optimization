%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ALGORITMO GENETICO: Diseño de un voladizo de sección rectangular y 
%                    longitud dada para conseguir peso mínimo
%SOLUCION: El valor de las variables del problema son:
%    0.5    0.0928
%El valor de la función objetivo es: 4.641589
%El valor de la restricción (no lineal): 0.994583
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inicializa();

global N E G tipo_seleccion psel nuintor tipo_cruce pcru tipo_mutacion ...
    nvars lb ub nbits tot_bits 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            % PARAMETROS DEL PROBLEMA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Numero de variables del problema
nvars=4;      
%Limite inferior de los valores de las variables
lb=[0.0625,0.0625,10,10];
%Limite superior de los valores de las variables 
ub=[0.0625*99,0.0625*99,200,240];
%Número de decimales de precisión
dprec = 9;
%Número de bits con que se codifica cada variable
nbits = zeros(1,nvars);
tot_bits = 0;
for i=1:1:nvars
    nbits(i) = ceil(log10((ub(i)-lb(i))*10^dprec)/log10(2.));
    tot_bits = tot_bits + nbits(i) ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         % PARAMETROS DEL ALGORITMO GENETICO 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
%Numero de GENERACIONES
G=150;
%Numero de INDIVIDUOS de la poblacion (un numero par)
N=100;
%Numero de INDIVIDUOS ELITISTAS
E=1;  %si E=0 se sobreentiende que no se aplica elitismo
%Operador de selección:    0:proporcional    1:torneo probabilístico    2:torneo    
tipo_seleccion=2;
%Probabilidad de selección del mejor para el torneo probabilístico (1)
psel=0.75;
%Número de padres que intervienen en el torneo (2)
nuintor = 3;
%Operador de cruce:   0:cruce un punto   1:cruce dos puntos   2:cruce uniforme
tipo_cruce=2;
%Probabilidad de cruce (prob. se realice cruce)
pcru=0.8;
%Operador de mutación:   0:un bit   1:dos bits    2:uniforme
tipo_mutacion=2;
%número de ensayos diferentes que se quieren realizar (>10)
ensayos=30;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     % GRAN BUCLE QUE VA GENERANDO LOS ENSAYOS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
best = zeros(ensayos,nvars);
fbest = zeros(1,nvars);

for nensayo=1:ensayos
  
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ti=cputime;              %recoge tiempo cuando empieza la optimización   
   [best(nensayo,:),fbest(nensayo)]=GA(nensayo,ensayos);
 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        % IMPRIMIR-GRAFICAR RESULTADOS 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   tf=cputime-ti;              %recoge tiempo cuando termina la optimización
   muestratiempo(nensayo,tf);  %mostrar tiempos

%    if ensayos == 1
%        mostrar_solucion(best,fbest);
%    else
%        format long
%        disp ('El valor de las variables del problema son:')
%        disp (best(nensayo,:))
%        disp ('El valor de la función objetivo es:')
%        disp (fbest(nensayo))
%        fprintf('\n');
%    end

end %FIN for jj=1:ensayos

[fvalmin,nmin] = min(fbest);
mejor = best(nmin,:);
fvalmejor = fbest(nmin);

fprintf('\nLa mejor solución se encontró en (TS,TH,R,L) = (%.3f,%.3f,%.3f,%.3f)',mejor(1),mejor(2),mejor(3),mejor(4));
fprintf('\nEl valor de coste en dicho punto es f = %f\n',fvalmejor);

%-------------------
%Estudio estadístico
%-------------------
fprintf('\nEl valor medio de los mejores encontrados es ffmean = %.2f',mean(fbest));
fprintf('\nLa desviación típica de los mejores encontrados es ffstd = %.2f',std(fbest));
fprintf('\nCuartiles = %.2f %.2f %.2f %.2f %.2f\n',quantile(fbest,(0:0.25:1)));

figure;
subplot(3,1,1)
plot(fbest,'--gs','LineWidth',2,'MarkerSize',6,...
    'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
xlabel('Trial')
ylabel('Fitness Function')
subplot(3,1,2)
boxplot(fbest,'orientation','horizontal');
xlabel('Fitness Function')
title('Boxplot');
subplot(3,1,3)
histogram(fbest);
xlabel('Fitness Function')
title('Histogram');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  % FIN  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%