function ruta = rutaVehiculo(S,x,isRamdon)
    % Funcion que retorna la ruta del vehiculo
    if isRamdon == "S"
        % Retorna una ruta aleatoria excluyendo la mas probable.
        % Si el vehiculo solo cuenta con una ruta, tomara la ruta que
        % exista

        % Se valida cuantas rutas tiene el vehiculo
        if size(S.vehicle(x).routeDistribution.route,2) > 1
            % Si el vehiculo tiene mas de una ruta que escojer.

            % Retorna el indice de la ruta del vehiculo mas probable
            indexProbabilityMax = calculoMaxProbable(S,x);

            % recorremos en ciclo una ruta aleatorioa diferente de la mas
            % probable
            while true
                nuRamdon = round(1 + (size(S.vehicle(x).routeDistribution.route,2) -1) .* rand(1,1));
                if nuRamdon~=indexProbabilityMax
                    break
                end
            end

            ruta = S.vehicle(x).routeDistribution.route(nuRamdon).edgesAttribute;
        else
           % De solo tener una ruta, toma la que exista
           ruta = S.vehicle(x).routeDistribution.route(1).edgesAttribute;
        end

    else
        % Retorna el indice de la ruta del vehiculo mas probable
        indexProbabilityMax = calculoMaxProbable(S,x);

        % Asignamos la ruta del vehiculo mas probable
        ruta = S.vehicle(x).routeDistribution.route(indexProbabilityMax).edgesAttribute;
    end

end