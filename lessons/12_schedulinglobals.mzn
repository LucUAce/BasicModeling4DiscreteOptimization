% Patrol Scheduling
/*
particiones, calendario turnos.  
usar global constraints lo hace mucho mas eficiente, igual que usar variables intermedias en vez de clacular varias veces lo mismo.


*/


include "globals.mzn";
/*
familia de global constraints: 
global_cardinality([roster[s,d] | s in SOLDIER], [NIGHT, EVE], [o, onEve[d]])):   revisa que roster tenga "o" veces NIGHT y "onEve[d]" veces EVE. Puede tener otros valores. se puede poner para limitar la cantidad de un elemento o para contar esa cantidad y guardarlo en un array. 

 global_cardinality_closed:  lo mismo de antes pero roster no podria tener mas elementos que los indicados (no puede existir un MORNING por ejemplo)
 
  global_cardinality_low_up(x, v, lo, hi):  en vez de poner una cantidad fija, se pone el minimo lo y el maximo hide elementos para cada item
  
  global_cardinality_low_up_closed:  lo mismo de antes pero x no puede tener mas valores de los indicados.

*/
enum SOLDIER;
enum SHIFT = {OFF, EVE, NIGHT};

int: nDays; % length of the period
set of int: DAY = 1..nDays;

int: o;
int: l;
int: u;

array[SOLDIER, DAY] of var SHIFT: roster;

%no + de 2 noches seguidas
constraint forall (d in 1..(nDays-2), s in SOLDIER) ((roster[s,d] = NIGHT) /\ (roster[s,d+1] = NIGHT) -> (roster[s,d+2] != NIGHT));
% si evenening entonces no noche
constraint forall (d in 1..(nDays-1), s in SOLDIER) ((roster[s,d] = EVE) -> (roster[s,d+1] != NIGHT));

array[DAY] of var l..u: onEve;
constraint forall (d in DAY) (global_cardinality([roster[s,d] | s in SOLDIER], [NIGHT, EVE], [o, onEve[d]]));

solve maximize sum(onEve);


output ["Soldier \(s) on Day \(d) takes the \(roster[s,d]) shift\n" 
        ++ if s == max(SOLDIER) then "\(onEve[d])\n" else "" endif | d in DAY, s in SOLDIER]++[show(sum(onEve))];