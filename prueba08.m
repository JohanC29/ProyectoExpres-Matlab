matrizVehiculo=["IdVehiculo","tiempoInicio","Ruta","indice"];

numVehiculo = size(S.vehicle,2);
columaTiempo = 0;
for x=1: numVehiculo
    nuProbabilityMax = 0;
    for i=1: size(S.vehicle(x).routeDistribution.route,2)
        if S.vehicle(x).routeDistribution.route(i).probabilityAttribute >= nuProbabilityMax
            nuProbabilityMax = S.vehicle(x).routeDistribution.route(i).probabilityAttribute;
            vaRuta = S.vehicle(x).routeDistribution.route(i).edgesAttribute;
        end 
    end

    result = split(vaRuta);
    
    if size(split(vaRuta),1)+ S.vehicle(x).departAttribute >= columaTiempo
        columaTiempo = size(split(vaRuta),1)+ S.vehicle(x).departAttribute;
    end

    matrizVehiculo = [matrizVehiculo;[S.vehicle(x).idAttribute,S.vehicle(x).departAttribute,vaRuta,x]];

end



matriZero = ["0";"0"];

for i=2: numVehiculo+1
    matriZero(i,1)=S.vehicle(i-1).idAttribute;
    for j=2: columaTiempo+1
        matriZero(i,j)="0";
        if i==2
          matriZero(1,j) = j-2;
        end
    end
end

matiz = matriZero;


for i=2: size(matiz,1)
    idVehiculo = matiz(i,1);
    matriZero(i,1)=S.vehicle(i-1).idAttribute;
    for j=2: columaTiempo+1
        matriZero(i,j)="0";
        if i==2
          matriZero(1,j) = j-2;
        end
    end
end


matrizVehiculo