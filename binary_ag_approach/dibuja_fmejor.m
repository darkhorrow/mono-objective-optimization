%FUNCION DIBUJA GRAFICAS
function dibuja_fmejor(numgen,gen,vfmejor)

%dibuja soluciones obtenidas
plot(gen,vfmejor,'--rs','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10);
%detalles de la figura
if gen==1
    xlim([0 numgen])
%     ylim([0 vfmejor])
    xlabel('Iteración','FontSize', 12); %etiqueta eje x
    ylabel('Valor de la función de aptitud','FontSize', 12); %etiqueta eje y
    hold on;
end
title(['Actual valor de la función: ',num2str(vfmejor)],'FontSize', 12,'FontName','Times'); %título

end