function [ ] = dibujacamino(Solucion, grafo)

Solucion = [Solucion , Solucion(1)];

hold on
for i = 1 : length(Solucion) - 1
    
    NodoActual = Solucion(i);
    NodeProximo =  Solucion(i+1);
    
    x1 = grafo.nodo(NodoActual).x;
    y1 = grafo.nodo(NodoActual).y;
    
    x2 = grafo.nodo(NodeProximo).x;
    y2 = grafo.nodo(NodeProximo).y;
    
    X = [x1 , x2];
    Y = [y1, y2];
    plot (X, Y, '-r');

end
    
X = [grafo.nodo(:).x];
Y = [grafo.nodo(:).y];
    
plot(X, Y, 'ok', 'markerSize' , 10 , 'MarkerEdgeColor' , 'r' , 'MarkerFaceColor', [1, 0.6, 0.6]);

text([grafo.nodo(:).x],[grafo.nodo(:).y],grafo.nombres(:));

box('on');