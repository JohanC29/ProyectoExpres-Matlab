function result = calculadorFallas(matrizCelda, NuaMax, NuCantidadEjecucion)

    % Cantidad de carros en una misma celda para no conciderarce falla
    arregloEjecuciones = [];

    for cantidad=1: NuCantidadEjecucion 
        % Arreglo con todos los carros que fallaron
        arregloCarrosFallos = [];
        
        % Contar id de carros con falla
         for j=2: size(matrizCelda,2)
            a = matrizCelda(2:size(matrizCelda,1),j);
            a = unique(a);
            for x=1: size(a,1)
                if a(x) ~= "0"
                    carrosCelda = [];
                    % Comparar cuantas veces se repite la celda en el tiempo
                    for i=2: size(matrizCelda,1)
                       if a(x) == matrizCelda(i,j)
                           carrosCelda = [carrosCelda,matrizCelda(i,1)];
                       end
                    end
        
                    % Valido si la cantidad de carros permitidos por celda es igual
                    % o supera la cantidad de carros encontrados en la misma celda en el mismo
                    % momento
                    if  NuaMax >= size(carrosCelda,2)
                        carrosCelda = [];
                    else
                        % tatal de fallos sobre total de carros
                         for y=1: NuaMax
                            % disp(carrosCelda);
                            r = round(1 + (size(carrosCelda,2) -1) .* rand(1,1));
                            
                            %Eliminamos un carro aleatorio, dejando en el vector
                            %Solo los carros con falla  
                            carrosCelda(r) = [];
                         end
                    end
                     
                     arregloCarrosFallos = [arregloCarrosFallos,carrosCelda];
                end
            end
            
        
         end
        
        % Quitamos duplicados
        arregloCarrosFallos = unique(arregloCarrosFallos);
        
        % Cantidad de carros con falla
        if ~isempty(arregloCarrosFallos)
           arregloEjecuciones = [arregloEjecuciones,length(arregloCarrosFallos)];
        end
    end

%     disp("Promedio Fallos: "+mean(arregloEjecuciones));
    result.promedioFallos = mean(arregloEjecuciones);
%     disp("Cantidad de Carros: "+(size(matriz,1)-1)); 
    result.cantidadCarros = (size(matrizCelda,1)-1);

%     disp("Porcentaje: "+ (mean(arregloEjecuciones)/size(matriz,1)*100)+"%")
    result.porcentaje = (mean(arregloEjecuciones)/size(matrizCelda,1)*100);
    
%     retornamos el resultado por ejeciones
    result.arregloEjecuciones = arregloEjecuciones;

end