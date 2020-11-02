function statistics(ensayos,fbest,fworst,fmean,fstd,fmedian,ffeval)

disp(' ');
str = sprintf('El número de ensayos válidos realizados es %d',ensayos);
disp(str);
str = sprintf('El valor medio de los mejores encontrados es %.2f',mean(fbest));
disp(str);
str = sprintf('La desviación típica de los mejores encontrados es %.2f',std(fbest));
disp(str);
str = sprintf('Cuartiles = %.2f %.2f %.2f %.2f %.2f',quantile(fbest,(0:0.25:1)));
disp(str);

%Guardamos los resultados obtenidos en fichero
fid = fopen('statistics.txt', 'w');
fprintf(fid,' mejor peor media sdt mediana nevalf');
for nensayo=1:ensayos
    fprintf(fid,'\n%d %f %f %f %f %f %d',nensayo,fbest(nensayo),fworst(nensayo),...
        fmean(nensayo),fstd(nensayo),fmedian(nensayo),ffeval);
end
fclose(fid);


%Representación gráfica de los resultados
figure (1)
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
hist(fbest);
xlabel('Fitness Function')
title('Histogram');


figure (2)
plot(fbest,'ro','MarkerFaceColor',[1,0,0]);
xlim([0 ensayos+1]);grid;
hold on
plot(fworst,'ks','MarkerSize',8);
plot(fmedian,'b:.');
legend('best','worst','median','Location','NorthEast')
hold off

end