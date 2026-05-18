/*
elegir que movimientos priorizar de aprender para maximizar el poder en x tiempo.
usar sets en vez de integers 0,1 o bool. 
*/

int: nMoves;
set of int: MOVES = 1..nMoves;
int: timeBound;
array[MOVES] of 1..20: power;
array[MOVES] of 1..10: duration;
%Occur es un subconjunto de MOVES. es equivalente a darle un valor de 0,1 o un bool a cada valor de moves
var set of MOVES: occur;

constraint (sum(i in occur)(duration[i])) <= timeBound;

solve maximize sum(i in occur)(power[i]);

output [show(occur)];