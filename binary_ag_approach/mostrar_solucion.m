function mostrar_solucion(x)

global nvars

[coste_total, volumen, factible] = evalua_solucion(x);

fprintf('     TS         TH         R         L\n');

for j=1:nvars
    fprintf('%10.3f ',x(j));
end

fprintf('\n\n');

fprintf('Coste total: %10.4e\n', coste_total);
fprintf('Volumen óptimo: %10.4e\n', volumen);

if factible
    fprintf("Solución válida\n");
else
    fprintf("Solución no factible\n");
end

end