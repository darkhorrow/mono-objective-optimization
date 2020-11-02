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
    nvars lb ub nbits tot_bits ngendibujo 

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
dprec = 4;
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
%Número de padres que intervienen en el torneo (2): 2, 3 o 5
nuintor = 3;
%Operador de cruce:   0:cruce un punto   1:cruce dos puntos   2:cruce uniforme
tipo_cruce=2;
%Probabilidad de cruce (prob. se realice cruce)
pcru=0.8;
%Operador de mutación:   0:un bit   1:dos bits    2:uniforme
tipo_mutacion=2;
%Cada cuántas generaciones se dibuja el valor del mejor
ngendibujo = 10; 
%número de ensayos diferentes que se quieren realizar
ensayos=1;    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     % GRAN BUCLE QUE VA GENERANDO LOS ENSAYOS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for jj=1:ensayos
  
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ti=cputime;              %recoge tiempo cuando empieza la optimización   
   [mejor,fmejor]=GA(jj,ensayos);
 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        % IMPRIMIR-GRAFICAR RESULTADOS 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   tf=cputime-ti;            %recoge tiempo cuando termina la optimización
   muestratiempo(jj,tf);     %mostrar tiempos

   if ensayos == 1
       mostrar_solucion(mejor);
   else
       format long
       disp('El valor de las variables del problema son:')
       disp(mejor)
       disp('El valor de la función objetivo es:')
       disp(fmejor)
       fprintf('\n');
   end

end %FIN for jj=1:ensayos

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  % FIN  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%