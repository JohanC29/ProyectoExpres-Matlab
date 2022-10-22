
for i=2: size(matrizVehiculo,1)
    rutasArreglo = split(matrizVehiculo(i,3));

     j = str2double(matrizVehiculo(i,2));
     for k=1: size(rutasArreglo,1)
        matriz(str2double(matrizVehiculo(i,4))+1,(j+2)) = rutasArreglo(k);
        %disp("Fila "+ (str2double(matrizVehiculo(i,4))+1)  + " - Columna "+ (j+2) +" - Dato "+matriz(str2double(matrizVehiculo(i,4))+1,(j+2)))
        j = j + 1;
     end
end

