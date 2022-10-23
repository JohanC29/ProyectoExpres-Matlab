function matriZero = mapeoMatrizBase(matrizVehiculo)
    
    matriZero = ["0";"0"];
    % Obtenemos el numero de vahiculos
    numVehiculo = size(matrizVehiculo,1)-1;

    % Obtenemos la ruta mas extenza de la matriz de vehiculos
    columaTiempo = 0;
    for i=2: size(matrizVehiculo,1)
        rutaSplit = split(matrizVehiculo(i,3));

        % Valido el tiempo maximo entre la cantidad de rutas y el tiempo de
        % inicio del vehiculo
        if (length(rutaSplit) + str2double(matrizVehiculo(i,2))) >= columaTiempo
            columaTiempo = length(rutaSplit) + str2double(matrizVehiculo(i,2));
        end        
    end

    % Armo la matriz mapeando el tiempo, los vehiculos
    for i=2: numVehiculo+1
        matriZero(i,1)= matrizVehiculo(i,1);
        for j=2: columaTiempo+1

            % Inicializo el tiempo del primer vehiculo
            if i==2 && j==2
               matriZero(1,j) = min(str2double(matrizVehiculo(2:size(matrizVehiculo,1),2)));
            end

            % Seteo el consecutivo del tiempo
            if i==2 && j~=2
              matriZero(1,j) = str2double(matriZero(1,(j-1))) + 1; 
            end

            matriZero(i,j)="0";
        end
    end

end