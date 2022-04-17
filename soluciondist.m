function [soluciond] = soluciondist(tour,grafo)
%obtener la distancia total de la solucion generada

soluciond=0;

for i=1:length(tour) -1
    
    Nodoactual=tour(i);
    Nodosig=tour(i+1);
    
    soluciond= soluciond+ grafo.caminos(Nodoactual,Nodosig);
    
end
soluciond = (-soluciond); % - para minimización 
end