function [individuo_real]=bin2real(individuo)

global nvars nbits lb ub

%formula: xi=a+(i-1)(b-a/2^mi-1) con mi=nº de bits de la variable xi,  
%que simplificamos según xi=a+(i-1)*resolucion con 1<=i<=2^l

individuo_real =zeros(1,nvars);

inicio = 0;
for nj=1:nvars,
    resolucion = (ub(nj)-lb(nj))/(2^nbits(nj)-1);
    ii = 1;
    for ni=1:nbits(nj),
        ii = ii + individuo(inicio+ni)*2^(nbits(nj)-ni);
        %fprintf('ii=%d\n',ii);
    end
    individuo_real(nj) = lb(nj) + (ii-1)*resolucion;
    
    inicio = inicio + nbits(nj);
end

end