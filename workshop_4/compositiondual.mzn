include "inverse.mzn";

int: n;

array[1..n] of var 1..n: order;
array[1..n-1] of var 1..n-1: diffs;

array[1..n] of var 1..n: posn;
array[1..n-1] of var 1..n-1: dposn;

constraint inverse(order, posn) /\ inverse(diffs, dposn);

constraint abs(posn[1] - posn[n]) = 1 /\  dposn[n - 1] = min(posn[1],posn[n]);

constraint forall(i in 1..n-1)(abs(order[i]-order[i+1])=diffs[i]);

solve satisfy;


% se puee mejorar el espaciado usando los digitos de los numeros (ln(n+1)/ln(10)), 
% y con show_int(d,integer) el integer se pone como string+ numero de espacios d   
output [
  concat([show(order[j]) ++ "   " | j in 1..n]) ++ "\n  " ++
  concat([show(diffs[k]) ++ "   " | k in 1..n-1])
];