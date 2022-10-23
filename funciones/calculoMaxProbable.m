function indexProbabilityMax = calculoMaxProbable(S,x)
    % Retorna la ruta del vehiculo mas probable
    nuProbabilityMax = 0;
    for i=1: size(S.vehicle(x).routeDistribution.route,2)
        if S.vehicle(x).routeDistribution.route(i).probabilityAttribute >= nuProbabilityMax
            nuProbabilityMax = S.vehicle(x).routeDistribution.route(i).probabilityAttribute;
            % rutaMaxProbable = S.vehicle(x).routeDistribution.route(i).edgesAttribute;
            indexProbabilityMax = i;
        end 
    end
end