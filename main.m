% Variables utilizadas para el proceso
rutaArchivo = "archivos/InTAS_001.rou.xml"; % Variable de la ubicacion del archivo

% Cantidad de carros permitidos en una celda al tiempo
NuaMax = 1;

% Cantidad de repeticiones para el calculo promedio
NuCantidadEjecucion = 1;


% Ejecucion de acuerdo a la tabla
resultados = [0, 0.2, 0.4, 0.6, 0.8, 1; 0,0,0,0,0,0];

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
    S = lecturaArchivo(rutaArchivo);

    % Resultados de cada iteracion para calcular el promedio del ciclo de
    % eleccion de rutas hasta el calculo del promedio de celdas
    resultadoPromedio = [];
    
    % Ubicamos en ciclo la ejecucion desde la seleccion de rutas para
    % calcular el promedio
    for cantidadEjecuciones=1: NuCantidadEjecucion

        % Obtenemos la matriz conformada por idVehiculo, TiempoInicio, Ruta e
        % Indice
        mVehiculo =  matrizVehiculo(S, porcentajeRutaMayorProbabilidad);
        
        % Llenado de la matriz base, Matriz con vehiculos y tiempo
        matrizBase = mapeoMatrizBase(mVehiculo);
        
        % Llenado de la matriz de rutas con base en la matriz de vehiculos
        matriz = mapeoMatriz(matrizBase, mVehiculo);
        
        % llenado de la base de celdas calle
        mCeldasRutas = lecturaVariable('archivos/variables/CeldasCalles.mat');
        
        % Mapeo de la matriz con las celdas
        matrizCelda = mapeoMatrizCelda(matriz, mCeldasRutas, matrizBase);
        
        % Calculamos la cantidad de carros fallidos
        %resultado = calculadorFallas(matrizCelda, NuaMax, NuCantidadEjecucion);
        resultado = calculadorFallas(matrizCelda, NuaMax, 1);
        
        % Almaceno el promedio de ejecuciones
        resultadoPromedio =[resultadoPromedio, resultado.promedioFallos];
        disp(cantidadEjecuciones);
    end

    % Almacenamos el promedio de fallas
    resultados(2,ciclo) = mean(resultadoPromedio);

    % Imprimimos los resultados generados almacenados en la varaible resultado
    disp("Ejecucion Porcentaje de incertidumbre: "+resultados(1,ciclo));
    disp("Promedio Fallos: "+resultados(2,ciclo));
    disp("Cantidad de Carros: "+ size(S.vehicle,2)); 
    disp("Porcentaje: "+ (  resultados(1,ciclo)/size(S.vehicle,2)*100  ) +"%");
    
end
% =====================================================================================
% Finaliza el proceso 
% =====================================================================================
disp("====== Finaliza Ejecucion "+string(datetime)+" ========");
disp(resultados);




