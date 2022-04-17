function [mejordist, mejorruta] = fuerzabruta(matrizDist)
%generar el mejor camino por fuerza bruta
%requiere de entrada la matriz con las distancias de cada punto

mejordist = 0;

for ruta = perms(2:size(matrizDist, 1))' 
    ruta = [1, ruta', 1];
    distance = 0;
    for i = 1:size(ruta,2) - 1
        distance = distance + matrizDist(ruta(i), ruta(i + 1));
    end
    if distance < mejordist || ~mejordist %evaluar cada propuesta
        mejordist = distance;
        mejorruta = ruta;
    end
end

end