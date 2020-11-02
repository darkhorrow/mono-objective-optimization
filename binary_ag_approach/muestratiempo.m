function muestratiempo(jj,tf)

fprintf('\n---------------------------------------------------------------\n');  
fprintf('Ensayo %d:',jj);
fprintf('\n---------------------------------------------------------------\n');  
if tf<60
    fprintf('Tiempo segundos: %.3f sg.\n\n',tf);
else
    fprintf('Tiempo minutos: %.3f min.\n\n',tf/60);  
end

end