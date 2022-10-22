% Variables utilizadas para el proceso
rutaArchivo = "archivo/InTAS_001.rou.xml"; % Variable de la ubicacion del archivo

% Variable que indica el porcentaje de vehiculos que tomaran la ruta mas probable
% Entre mayor sea el porcentaje la cantidad de vahiculos tomaran la ruta
% mas probable
porcentajeRutaMayorProbabilidad = 0.80; 


% Lectura del archivo y cargar en varable la informacion
S = lecturaArchivo(rutaArchivo);

% Obtenemos la matriz conformada por idVehiculo, TiempoInicio, Ruta e
% Indice
mVehiculo =  matrizVehiculo(S, porcentajeRutaMayorProbabilidad);

% Llenado de la matriz de rutas con base en la matriz de vehiculos


