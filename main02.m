% Variables utilizadas para el proceso
rutaArchivo = "archivos/PruebaJC.xml"; % Variable de la ubicacion del archivo

% Cantidad de carros permitidos en una celda al tiempo
NuaMax = 1;

% Cantidad de repeticiones para el calculo promedio
NuCantidadEjecucion = 1;


% Ejecucion de acuerdo a la tabla
% resultados = [0, 0.2, 0.4, 0.6, 0.8, 1; 0,0,0,0,0,0];
resultados = [0 ; 0];

disp("====== Inicia Ejecucion "+string(datetime)+" ========")
% =====================================================================================
% Inicio del proceso
% =====================================================================================

for ciclo=1: size(resultados,2)

    % Variable que indica el porcentaje de vehiculos que tomaran la ruta mas probable
    % Entre mayor sea el porcentaje la cantidad de vahiculos tomaran la ruta
    % mas probable
    % porcentajeRutaMayorProbabilidad = 0.80;

    porcentajeRutaMayorProbabilidad = 1-resultados(1,ciclo);
    % Lectura del archivo y cargar en varable la informacion
    S1 = lecturaArchivo(rutaArchivo);

    % Resultados de cada iteracion para calcular el promedio del ciclo de
    % eleccion de rutas hasta el calculo del promedio de celdas
    resultadoPromedio = [];


    matrizNueva = ["Tiempo","Via","Vehiculo"];
    %Se recorre la cantidad de tiempo
    for i=1: size(S1.timestep,2)

        %Se recorre la cantidad de vias
        for j=1: size(S1.timestep(i).edge,2)

            % Se recorren la cantidad de vehiculos
            for k=1: size(S1.timestep(i).edge(j).lane,2)
                if ~ismissing(S1.timestep(i).edge(j).lane(k).vehicle)

                    % Validamos la cantidad de vehiculos
                    for l=1:size(S1.timestep(i).edge(j).lane(k).vehicle,2)
                        % Organizamos la matriz nueva con los datos relevantes del
                        % archivo cargado
                        prueba = [i,j,k,l];

                        fila = [S1.timestep(i).timeAttribute, S1.timestep(i).edge(j).idAttribute, S1.timestep(i).edge(j).lane(k).vehicle(l).idAttribute];
                        matrizNueva = [matrizNueva; fila];
                    end

                end

            end

        end

    end

    % Iniciamos con el mapeo de la matriz base con los datos obtenidos
    
    % Mapeo del tiempo en la columna
    aregloTiempo = matrizNueva(2:size(matrizNueva,1));
    aregloTiempo = str2double(aregloTiempo);
    tiempoFila = min(aregloTiempo):max(aregloTiempo);
    
    % Mapeo de los id de los carros en fila
    arregloVehiculo = matrizNueva(2:size(matrizNueva,1),3);
    arregloVehiculo = unique(arregloVehiculo);

    % Armado de Matriz Base
    matrizBase = ["0";"0"];
    
    for i=1: size(arregloVehiculo,1)+1
        for j=1: size(tiempoFila,2)+1
            if j==1 && i>1
                matrizBase(i,j) = arregloVehiculo(i-1);
            elseif i==1 && j>1
                matrizBase(i,j) = tiempoFila(j-1);
            else
                matrizBase(i,j) = 0;
            end
    
        end
    end
    matriz = matrizBase;

    % Mapeo de las rutas en vehiculo y tiempo
    for x=2: size(matrizNueva,1)
        % Recorremos la matriz base para ubicar la ruta
        for i=2: size(matriz,1)
            % Validamos que el id de la matriz corresponda al id de la lista
           if matriz(i,1) == matrizNueva(x,3)
    
               % Ubicamos el tiempo del vehiculo
               for j=2: size(matriz,2)
                   if matriz(1,j) == matrizNueva(x,1)
                       matriz(i,j) = matrizNueva(x,2);
                       break;
                   end
               end
               break;
           end
        end
    end

    % llenado de la base de celdas calle
    mCeldasRutas = lecturaVariable('archivos/variables/CeldasCalles.mat');

    % Ubicamos en ciclo la ejecucion desde la seleccion de rutas para
    % calcular el promedio
    for cantidadEjecuciones=1: NuCantidadEjecucion

        % Mapeo de la matriz con las celdas
        matrizCelda = mapeoMatrizCelda(matriz, mCeldasRutas, matrizBase);

        % Calculamos la cantidad de carros fallidos
        % resultado = calculadorFallas(matrizCelda, NuaMax, NuCantidadEjecucion);
        % resultado = calculadorFallas(matrizCelda, NuaMax, 1);
        resultado = calculadorFallas(matriz, NuaMax, 1);

        % Almaceno el promedio de ejecuciones
        resultadoPromedio =[resultadoPromedio, resultado.promedioFallos];
        disp(cantidadEjecuciones);
    end

    % Almacenamos el promedio de fallas
    resultados(2,ciclo) = mean(resultadoPromedio);

    % Imprimimos los resultados generados almacenados en la varaible resultado
    disp("Ejecucion Porcentaje de incertidumbre: "+resultados(1,ciclo));
    disp("Promedio Fallos: "+resultados(2,ciclo));
    disp("Cantidad de Carros: "+ length(arregloVehiculo));
    disp("Porcentaje: "+ (  resultados(1,ciclo)/length(arregloVehiculo)*100  ) +"%");

end
% =====================================================================================
% Finaliza el proceso
% =====================================================================================
disp("====== Finaliza Ejecucion "+string(datetime)+" ========");
disp(resultados);




