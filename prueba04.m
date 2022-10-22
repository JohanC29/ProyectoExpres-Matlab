
function result = maxRouteEdges(x)
    nuProbabilityMax = 0;
    for i=1: size(S.vehicle(x).routeDistribution.route,2)
        if S.vehicle(x).routeDistribution.route(i).probabilityAttribute >= nuProbabilityMax
            nuProbabilityMax = S.vehicle(x).routeDistribution.route(i).probabilityAttribute;
            vaRuta = S.vehicle(x).routeDistribution.route(i).edgesAttribute;
        end 
    end
    result = vaRuta;
end
nuProbabilityMax = 0;
x = 2;
for i=1: size(S.vehicle(x).routeDistribution.route,2)
    if S.vehicle(x).routeDistribution.route(i).probabilityAttribute >= nuProbabilityMax
        nuProbabilityMax = S.vehicle(x).routeDistribution.route(i).probabilityAttribute;
        vaRuta = S.vehicle(x).routeDistribution.route(i).edgesAttribute;
    end 
end

disp(nuProbabilityMax);
disp(vaRuta);



