
matrizContadorCeldas = zeros(size(CeldasCalles,1), size(matriz,2)-1);

% disp(size(CeldasCalles,1))
% disp(size(matriz,2)-1)

for i=2: size(matriz,2)
    for j=2: size(matriz,1)
        if matriz(j,i) ~= "0"
            % Comparar el rutas con las celdas
            for k=1: size(CeldasCalles,1)
                for l=2: size(CeldasCalles,2)
                    if CeldasCalles(k,l)==matriz(j,i)
                        % Aumentamos 1 en la matriz de ceros
                        matrizContadorCeldas(k,i-1) = matrizContadorCeldas(k,i-1)+1;
                        %disp("CeldasCalles("+k+","+l+") "+CeldasCalles(k,l)+ " | " +"matriz("+j+","+i+") "+matriz(j,i) +" | "+ "matrizContadorCeldas("+k+","+(i-1)+")")
                    end
                end
            end
        end
    end
end
