cla
%coordenadas de 32 ciudades (1 por estado)
x = [-99.14,-100.4,-103.5,-100.35,-89.67,-117,-96.19,-106,-109.95,-93.1,-86.8,-107.4,-110.95,-104.66,-103.45,-98.3,-104.89,-102.58,-102.29,-100.97,-101.25,-104.33,-101.19,-98.74,-99.65,-99.22,-98.19,-99.90,-96.72,-92.94,-90.53,-98.23];
y = [19.43,20.6,20.7,25.7,21,32.5,19.18,28.63,22.9,16.9,21.15,24.8,29.08,24.02,25.53,26.08,21.51,22.77,21.88,22.15,21.01,19.11,19.7,20.11,19.28,18.92,19.04,16.83,17.07,17.99,19.84,19.31]; 
nombres={'CDMX','Queretaro','Guadalajara','Monterrey','Mérida','Tijuana','Veracruz','Chihuahua','Los Cabos','Tuxtla Gutierrez','Cancun','Culiacan','Hermosillo','Durango','Torreon','Reynosa','Tepic','Zacatecas','Aguascalientes','SLP','Guanajuato','Manzanillo','Morelia','Pachuca','Toluca','Cuernavaca','Puebla','Acapulco','Oaxaca','Villahermosa','Campeche','Tlaxcala'};

%ciudades a evaluar (manual)
Numciudades=32;

%ciudades a evaluar (aleatorio)
%Numciudades=randi([1 32],1,1);

%ciudades escogidas
ciudades=randperm(length(x),Numciudades);

%generar grafo con las ciudades escogidas
grafo.n = length(ciudades);
for i = 1 : grafo.n
    grafo.nodo(i).x = x(ciudades(i));
    grafo.nodo(i).y = y(ciudades(i));
    grafo.nombres(i)=nombres(ciudades(i));
end

%grafo.nombres=nombres;
grafo.caminos = zeros(grafo.n,grafo.n);

%Crear matriz con distancias entre cada punto
for i = 1 : grafo.n
    for j = 1: grafo.n
        x1 = grafo.nodo(i).x ;
        x2 = grafo.nodo(j).x;
        y1 = grafo.nodo(i).y;
        y2 = grafo.nodo(j).y;
        grafo.caminos(i,j)=sqrt((x1-x2)^2+(y1-y2)^2); %dist. euclidiana
        
    end
end

nVar = grafo.n;
A.posicion = randperm(nVar); %solucion aleatoria
A.distancia = soluciondist([A.posicion, A.posicion(1)],grafo);

%% Recocido simulado 
T0=15000;       % Temperatura inicial
T=T0;
alpha=0.9;     % factor de enfriamiento
iteraciones = 5000;

bestFitness = inf;
bestTour = [];

tic;
for t = 1 : iteraciones
%while T>0 %temperatura
    indice=randsample(length(A.posicion),2); %vecino aleatorio
    
    i=indice(1);
    j=indice(2);
    
    B.posicion = A.posicion;
    B.posicion(i) = A.posicion(j);
    B.posicion(j) = A.posicion(i);
    B.distancia = soluciondist([B.posicion,  B.posicion(1)],grafo);
    Delta = A.distancia-B.distancia; %delta distancia

    if Delta < 0  % buen movimiento
        A.distancia = B.distancia;
        A.posicion = B.posicion;
    else % mal movimiento
        P=exp(-Delta/T);
        if rand<=P
            A.distancia = B.distancia;
            A.posicion = B.posicion;
        end
    end
    T=alpha*T;
    
    if Numciudades <= 13
        figure (2);
        cla
        dibujacamino(A.posicion, grafo);
        title('Recocido Simulado camino')
        drawnow
    end
end
t1=toc; %tiempo ejecucion recocido

figure (2);
cla
dibujacamino(A.posicion, grafo);
title('Recocido Simulado camino final')


fprintf('Distancia total en Recocido:%.2f Tiempo: %.2f . \n',abs(A.distancia),t1);
if Numciudades<=12 %el algoritmo de fuerza bruta después de 13 ciudades causa problemas
    tic
    [mejordist,mejorcamino]=fuerzabruta(grafo.caminos);
    t2=toc; %tiempo fuerza bruta
    figure(3);
    cla
    dibujacamino(mejorcamino,grafo);
    title('Fuerza Bruta');
    fprintf('Distancia total Fuerza Bruta:%.2f Tiempo: %.2f . \n',mejordist,t2);
    error=mejordist-abs(A.distancia); 
    deltaT=t2-t1; %diferencia tiempo ejecucion
    fprintf('Error de distancias óptimas:%.2f Diferencia tiempo: %.2f . \n',error,deltaT);
end
