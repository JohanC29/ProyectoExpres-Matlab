function ruta = rutaVehiculo(S,x,isRamdon)
    % Funcion que retorna la ruta del vehiculo
    if isRamdon == "S"
        % Retorna una ruta aleatoria
        nuRamdon = round(1 + (size(S.vehicle(x).routeDistribution.route,2) -1) .* rand(1,1));
        ruta = S.vehicle(x).routeDistribution.route(nuRamdon).edgesAttribute;
    
    else
        % Retorna la ruta del vehiculo mas probable
        nuProbabilityMax = 0;
        for i=1: size(S.vehicle(x).routeDistribution.route,2)
            if S.vehicle(x).routeDistribution.route(i).probabilityAttribute >= nuProbabilityMax
                nuProbabilityMax = S.vehicle(x).routeDistribution.route(i).probabilityAttribute;
                ruta = S.vehicle(x).routeDistribution.route(i).edgesAttribute;
            end 
        end
    end

end