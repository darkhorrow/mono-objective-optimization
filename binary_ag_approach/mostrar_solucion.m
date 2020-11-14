function mostrar_solucion(x)

global nvars

[coste_total, volumen, factible] = evalua_solucion(x);

fprintf('     TS         TH         R         L\n');

for j=1:nvars
    fprintf('%10.3f ',x(j));
end

fprintf('\n\n');

fprintf('Coste total: %10.4e\n', coste_total);
fprintf('Volumen �ptimo: %10.4e\n', volumen);

if factible
    fprintf("Soluci�n v�lida\n");
else
    fprintf("Soluci�n no factible\n");
end

end