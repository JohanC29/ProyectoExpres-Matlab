function matriz = mapeoMatriz(matriz, matrizVehiculo)
    % Realizamos el llenado de la matriz mapeando las rutas en su determinado
    % momento
    for i=2: size(matrizVehiculo,1)
        % Tomas las rutas del vehiculo y los colocamos en un arreglo para
        % mapearlo
        rutasArreglo = split(matrizVehiculo(i,3));
        
        %  Se establece el momento en que el carro inicia su recorrido
         j = str2double(matrizVehiculo(i,2));
         
         % Ubicamos cada ruta a partir del inicio del carro
         for k=1: size(rutasArreglo,1)
            matriz(str2double(matrizVehiculo(i,4))+1,(j+2)) = rutasArreglo(k);
            j = j + 1;
         end
    end
end