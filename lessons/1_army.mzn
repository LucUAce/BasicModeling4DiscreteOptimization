/*
MODELO PARA MAXIMIZAR FUERZA TROPAS. 
TROPAS "A" TIENEN 6 DE FUERZA, CUESTAN 13MONEDAS Y HAY 1000 DISPONIBLES PARA CONTRATAR.
*/

%todo acaba con ; 
solve maximize strength;

% tipos de variable: int, float, bool, o rango (como abajo las var de desicion)
%variables parametro no se pueden modificar, son un valor "fijo"
var int: strength = 6*A + 10*B + 8*C + 40*D;  

int: budget = 10000;
%constraint define las limitaciones/restricciones
constraint 13*A + 21*B + 17*C + 90*D <= budget;
%constraint A > 0;

%0..1000 ->  integer entre 0 y 1000. 
%variables de desicion, es la que el modelo tiene que encontrar
var 0..1000: A;
var 0..400: B;
var 0..500: C;
var 0..150: D;
%tmb se puede poner var {0,1,3,4}: E;  para decir qe E puede valer 0,1,3 o 4. 
%  o definir el nombre sin asignar valor var in: E;

%solo un output. \(variable) para printear el valor de la variable, ++ para concatenar, \n y \t
output ["A = \(A), B = \(B), C = \(C), D = \(D)\n" ++
        "strength = \(strength)\n" ++
        "budget = \(13*A + 21*B + 17*C + 90*D)\n" ++
        "size = \(A + B + C + D)\n"];

%resultados: ------  separa las diferentes respuestas, ====== indica que es la ultima/mejor respuesta. Si no encuentra respuestas printea ==UNSATISFIABLE==
