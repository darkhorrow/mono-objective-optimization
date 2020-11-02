function muestra_evolucion_tiempo(G,Z,jj)

if Z==1     
    fprintf('---------------------------------------------------------------\n');
    fprintf('                          ENSAYO %d                            \n',jj); 
    fprintf('---------------------------------------------------------------\n');
    fprintf('0%%');  
elseif (G*10)/100==Z
    fprintf('===10%%');    
elseif (G*20)/100==Z
    fprintf('===20%%'); 
elseif (G*30)/100==Z
    fprintf('===30%%');  
elseif (G*40)/100==Z
    fprintf('===40%%'); 
elseif (G*50)/100==Z
    fprintf('===50%%'); 
elseif (G*60)/100==Z
    fprintf('===60%%');  
elseif (G*70)/100==Z
    fprintf('===70%%'); 
elseif (G*80)/100==Z
    fprintf('===80%%');
elseif (G*90)/100==Z
    fprintf('===90%%');  
elseif Z==G 
    fprintf('===100%%');
end

end