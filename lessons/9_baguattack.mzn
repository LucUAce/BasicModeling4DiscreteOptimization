/*
decidir que ejercito ataca, cunado uno ataca otros conectados no pueden atacar. 
*/
/*
Si tuviesemos un size de que el set que buscamos tiene una cardinalidad fija, se podria hacer con array para que requiera menos comuputo, pero poniendo constraint para no duplicar casos (diferente orden, repetir items): 
                array[1..size] of var SPOT: attacks; 
                constraint forall(i in 1..size-1)(attacks[i] < attacks[i+1]);
Intentar tener biyection entre soluciones del modelo y soluciones del problema. Elegir bien si usar sets, arrays o qé, dependiendo del tamaño y numero de opciones/combinaciones.
*/
/*
si el size fuese un boundary (card <=size), se podria hacer con un array añadiendo un valor extra "0":
                set of int: SPOTx = {0} union SPOT;
despues hay que tener en cuanta los constraint para hacer valido el set, y los rangos del array que no afecten al resto de llamadas:
                constraint forall(i in 1..size-1)(attacks[i] >= (attacks[i] != 0) + attacks[i+1]);
                % el (attacks[i] != 0) es un bool que hace: si !=0 el >= es estricto, si =0 permite repetir mas 0
                ... var int: totalDamages = sum(p in attacks where p > 0)(damage[p]);
                % si p=0 damage[p] no estaria definido asi que forzaria que ningun valor de attacks pueda ser 0
SI card es fija o bounded, y es pequeña respecto el set completo, es mas eficiente hacerlo con arrays!
*/

int: nSpots;
set of int: SPOT = 1..nSpots;
array[SPOT] of int: damage;

enum SYMB;   
array[SYMB] of set of SPOT: group;

var set of SPOT: attacks; % decision variable (set variable)

%card es cardinalidad conjunto. solo un atacante por grupo de ejercitos
constraint forall(s in SYMB)(card(attacks intersect group[s]) <= 1);

var int: totalDamages = sum(p in attacks)(damage[p]);
solve maximize (totalDamages); % Goal: maximize attack reward

output["Attacks: ", show(attacks), " and damages: ", show(totalDamages)]