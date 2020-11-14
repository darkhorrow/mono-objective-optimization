function x = filtra_valor_valido(x_0, cuantum)

    parte_entera = fix(x_0/cuantum);
    parte_decimal = mod(x_0, cuantum);

    if parte_decimal > cuantum/2
        x = (parte_entera + 1) * cuantum;
    else
        x = parte_entera * cuantum;
    end

end