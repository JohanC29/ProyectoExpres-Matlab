% Variables utilizadas para el proceso
rutaArchivo = "archivos/InTAS_001.rou.xml"; % Variable de la ubicacion del archivo

% Variable que indica el porcentaje de vehiculos que tomaran la ruta mas probable
% Entre mayor sea el porcentaje la cantidad de vahiculos tomaran la ruta
% mas probable
porcentajeRutaMayorProbabilidad = 0.80; 

% Cantidad de carros permitidos en una celda al tiempo
NuaMax = 1;

% Cantidad de repeticiones para el calculo promedio
NuCantidadEjecucion = 30;

disp("====== Inicia Ejecucion "+string(datetime)+" ========")
% =====================================================================================
% Inicio del proceso 
% =====================================================================================

% Lectura del archivo y cargar en varable la informacion
S = lecturaArchivo(rutaArchivo);

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
resultado = calculadorFallas(matrizCelda, NuaMax, NuCantidadEjecucion);

% Imprimimos los resultados generados almacenados en la varaible resultado
disp("Promedio Fallos: "+resultado.promedioFallos);
disp("Cantidad de Carros: "+resultado.cantidadCarros); 
disp("Porcentaje: "+ resultado.porcentaje+"%");

% =====================================================================================
% Finaliza el proceso 
% =====================================================================================
disp("====== Finaliza Ejecucion "+string(datetime)+" ========")




