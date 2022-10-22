function matriZero = mapeoMatriz(matrizVehiculo)
    
    matriZero = ["0";"0"];
    % Obtenemos el numero de vahiculos
    numVehiculo = size(matrizVehiculo,1)-1;

    % Obtenemos la ruta mas extenza de la matriz de vehiculos
    columaTiempo = 

    for i=2: numVehiculo+1
        matriZero(i,1)= S.vehicle(i-1).idAttribute;
        for j=2: columaTiempo+1
            if i==2
              matriZero(1,j) = j-1;
            end
            matriZero(i,j)="0";
        end
    end

end