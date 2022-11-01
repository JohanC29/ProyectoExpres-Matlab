% Variables utilizadas para el proceso
rutaArchivo = "archivos/PruebaJC.xml"; % Variable de la ubicacion del archivo

% Lectura del archivo y cargar en varable la informacion
S1 = lecturaArchivo(rutaArchivo);

% Cantidad de carros permitidos en una celda al tiempo
NuaMax = 1;

%%
matrizNueva = ["Tiempo","Via","CantidadVehiculo"];

%Se recorre la cantidad de tiempo
for i=1: size(S1.timestep,2)

    %Se recorre la cantidad de vias
    for j=1: size(S1.timestep(i).edge,2)

        % Se recorren la cantidad de vehiculos
        fila = [S1.timestep(i).timeAttribute, S1.timestep(i).edge(j).idAttribute,  size(S1.timestep(i).edge(j).lane,2)];
        matrizNueva = [matrizNueva; fila];

%         for k=1: size(S1.timestep(i).edge(j).lane,2)
% 
%             fila = [S1.timestep(i).timeAttribute, S1.timestep(i).edge(j).idAttribute,  size(S1.timestep(i).edge(j).lane,2)];
%             matrizNueva = [matrizNueva; fila];
%         end
    end
end 

%% Cargar en memoria las celdas con las vias
% llenado de la base de celdas calle
mCeldasRutas = lecturaVariable('archivos/variables/CeldasCalles.mat');

%%
% Se saca las vias y se categorizan por celdas
arregloViaCelda = matrizNueva(2:size(matrizNueva,1),2);
arregloViaCelda = unique(arregloViaCelda);

% bandera de via encontrada en la matriz de celdas
nuBandera = 0;

% matriz via y celda
matrizViaCelda = ["Via","Celda"];

% Mapeo de las vias con las celdas
for x=1: size(arregloViaCelda,1)
    nuBandera = 0;

    % Mapeo de las celdas
    for i=1: size(mCeldasRutas,1)

        for j=2:  size(mCeldasRutas,2)
            % Valido si no existen mas rutas para la celda
            if mCeldasRutas(i,j) == ""
               break;
            end 

            if mCeldasRutas(i,j) == arregloViaCelda(x)
                matrizViaCelda = [matrizViaCelda;[ arregloViaCelda(x), mCeldasRutas(i,1)]];
                nuBandera = 1;
                %Saltamos a la siguiente celda
                break;
            end
        end

        if nuBandera==1
            % Saltamos a la siguiente via
            break;
        end
    end

end


%% Contamos cuantas veces se repiten las celdas en los diferentes tiempos
matrizNuevaCeldas = ["Tiempo","Via","CantidadVehiculo", "Celda"];

for x=2: size(matrizNueva,1)
    for i=2: size(matrizViaCelda,1)
        if matrizNueva(x,2)==matrizViaCelda(i,1)
            % 
            matrizNuevaCeldas = [matrizNuevaCeldas;[matrizNueva(x,1),matrizNueva(x,2), matrizNueva(x,3), matrizViaCelda(i,2)]];

            % Continuamos con el siguiente registro en matrizNueva
            break;
        end 
    end
end


%% Ubicamos el tiempo y las celdas en la matriz para obtener los resultados

% Mapeo del tiempo en la columna
aregloTiempo = matrizNuevaCeldas(2:size(matrizNuevaCeldas,1));
aregloTiempo = str2double(aregloTiempo);
tiempoFila = min(aregloTiempo):max(aregloTiempo);

% Mapeo de celdas
arregloCeldas = matrizNuevaCeldas(2:size(matrizNuevaCeldas,1),4);
arregloCeldas = unique(arregloCeldas);

% Armado de Matriz Base
matrizBase = ["0";"0"];

for i=1: size(arregloCeldas,1)+1
    for j=1: size(tiempoFila,2)+1
        if j==1 && i>1
            matrizBase(i,j) = arregloCeldas(i-1);
        elseif i==1 && j>1
            matrizBase(i,j) = tiempoFila(j-1);
        else
            matrizBase(i,j) = 0;
        end

    end
end
matriz = matrizBase;

%% Se cuenta en la matriz la cantidad de coincidencias entre tiempo y celdas

for x=2: size(matrizNuevaCeldas,1)
    for i=2: size(matriz,1)
        % Validamos la Celda
        if matrizNuevaCeldas(x,4)==matriz(i,1)
            for j=2: size(matriz,2)
                % Validamos el tiempo
                if matrizNuevaCeldas(x,1)==matriz(1,j)
                    matriz(i,j) = str2double(matriz(i,j))+str2double(matrizNuevaCeldas(x,3));
                end 
            end 
        end
    end
end

%% Filtramos por la cantidad de carros maximos

matrizNuevaCeldasFiltro = ["Tiempo","Via","CantidadVehiculo", "Celda"];

for x=2: size(matrizNuevaCeldas,1)
    if str2double(matrizNuevaCeldas(x,3))>NuaMax
        matrizNuevaCeldasFiltro = [matrizNuevaCeldasFiltro;[matrizNuevaCeldas(x,1),matrizNuevaCeldas(x,2),matrizNuevaCeldas(x,3),matrizNuevaCeldas(x,4)]];
    end 
end

%% Calculo de fallos v1

% Validamos la cantidad de fallos en la matriz, tomando en concideracion
% la cantidad de carros que estaban anterior mente en la matriz

matrizFallos = ["Tiempo","Celda"];

for j=2: size(matriz,2)
    for i=2: size(matriz,1)
        % Valido si la cantidad de vehiculos en la celda supera la cantidad
        % de vehiculos detectados
        if str2double(matriz(i,j))>NuaMax 

            % Valido si la cantidad de vehiculos es igual al periodo
            % anterior
            if j>2
                if matriz(i,j)~=matriz(i,(j-1))
                    % Cuenta como fallo
                    matrizFallos =[matrizFallos;[matriz(1,j), matriz(i,1)]];
                end
            else
                % Cuenta como fallo
                matrizFallos =[matrizFallos;[matriz(1,j), matriz(i,1)]];
            end 

        end
    end
end

%% Obtenermos la cantidad de fallos encontrados por celda

matrizCantidadFallosCelda = ["Celdas","CantidadFallos","PorcentajeFallos(%)"];
cantidadTotalFallos = size(matrizFallos,1);
for x=1: length(arregloCeldas)
    cantidad=0;
    for i=2: size(matrizFallos,1)
        if matrizFallos(i,2)==arregloCeldas(x)
            cantidad = cantidad+1;
        end
    end
    matrizCantidadFallosCelda = [matrizCantidadFallosCelda;[arregloCeldas(x),cantidad, (cantidad/cantidadTotalFallos*100)]];
end
%% Imprimir Resultados
disp(matrizCantidadFallosCelda);


