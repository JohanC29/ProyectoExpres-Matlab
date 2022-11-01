% Variables utilizadas para el proceso
rutaArchivo = "archivos/PruebaJC.xml"; % Variable de la ubicacion del archivo
% Lectura del archivo y cargar en varable la informacion
% S1 = lecturaArchivo(rutaArchivo);

% disp(S1.timestep(26).edge(11).lane(1).vehicle);
% rmm = ismissing(S1.timestep(26).edge(11).lane(1).vehicle);
% disp(rmm);

%matrizNueva = [];
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


%% 
% Iniciamos con el mapeo de la matriz base con los datos obtenidos

matrizBase2 = [];

% Mapeo del tiempo en la columna
aregloTiempo = matrizNueva(2:size(matrizNueva,1));
aregloTiempo = str2double(aregloTiempo);
tiempoFila = min(aregloTiempo):max(aregloTiempo);

% Mapeo de los id de los carros en fila
arregloVehiculo = matrizNueva(2:size(matrizNueva,1),3);
arregloVehiculo = unique(arregloVehiculo);



%% Armado de Matriz Base
matrizBase2 = ["0";"0"];

for i=1: size(arregloVehiculo,1)+1
    for j=1: size(tiempoFila,2)+1
        if j==1 && i>1
            matrizBase2(i,j) = arregloVehiculo(i-1);
        elseif i==1 && j>1
            matrizBase2(i,j) = tiempoFila(j-1);
        else
            matrizBase2(i,j) = 0;
        end

    end
end
matriz = matrizBase2;

%% Mapeo de las rutas en vehiculo y tiempo
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

%% Mapeo de matriz de celdas

% llenado de la base de celdas calle
mCeldasRutas = lecturaVariable('archivos/variables/CeldasCalles.mat');

% Mapeo de la matriz con las celdas
matrizCelda = mapeoMatrizCelda(matriz, mCeldasRutas, matrizBase2);

% Calculamos la cantidad de carros fallidos
%resultado = calculadorFallas(matrizCelda, NuaMax, NuCantidadEjecucion);
resultado = calculadorFallas(matriz, 1, 1);

disp(resultado);











