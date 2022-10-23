function matrizBase = mapeoMatrizCelda(matriz, CeldasCalles, matrizBase)

    for i=2: size(matriz,2)
        for j=2: size(matriz,1)
            if matriz(j,i) ~= "0"
                % Comparar el rutas con las celdas
                for k=1: size(CeldasCalles,1)
                    for l=2: size(CeldasCalles,2)
                        if CeldasCalles(k,l)==matriz(j,i)
                            matrizBase(j,i) = CeldasCalles(k,1);
%                             disp("CeldasCalles("+k+","+l+") "+CeldasCalles(k,l)+ " | " +"matrizCelda("+j+","+i+") "+matriz(j,i) +" | "+ "CeldasCalles("+k+","+1+") "+CeldasCalles(k,1))
                        end
                    end
                end
            end
        end
    end

end