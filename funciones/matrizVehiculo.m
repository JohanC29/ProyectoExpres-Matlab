function matrizResultado = matrizVehiculo(S, porcentajeRuta)
    % Funcion que se encarga de obtener matriz con la ruta seleccionada
    % por vehiculo. Adicional se almacena tiempo de inicio e indice

    % Obtenermos los encabezados de la matriz resultado
    matrizResultado=["IdVehiculo","tiempoInicio","Ruta","indiceVehiculo"];
    
    % Obtenemos la cantidad de vehiculos
    numVehiculo = size(S.vehicle,2);

    % Calculamos la cantidad de carros que tomaran rutas alternas
    cantidadCarrosAleatorios = numVehiculo - round(porcentajeRuta*numVehiculo);

    % Recorremos la cantidad de vehiculos como fila
    for x=1: numVehiculo

        % Definimos si el vehiculo se va por la ruta mas probable o la ruta
        % aleatoria
        isRamdon = "N";
        if cantidadCarrosAleatorios > 0
            isRamdon = "S";
            cantidadCarrosAleatorios = cantidadCarrosAleatorios-1;
        end
         

        % Obtenemos la ruta del vehiculo
        vaRuta = rutaVehiculo(S,x,isRamdon);
        matrizResultado = [matrizResultado;[S.vehicle(x).idAttribute,S.vehicle(x).departAttribute,vaRuta,x]];
    
    end

end