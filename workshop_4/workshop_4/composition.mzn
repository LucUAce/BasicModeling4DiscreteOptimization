include "alldifferent.mzn";

int: n;

array[1..n] of var 1..n: order;
array[1..n-1] of var 1..n-1: interval;

constraint alldifferent(order) /\ alldifferent(interval);

constraint forall(i in 1..n-1)(abs(order[i]-order[i+1])=interval[i]);

solve satisfy;

output [
  concat([show(order[j]) ++ "   " | j in 1..n]) ++ "\n  " ++
  concat([show(interval[k]) ++ "   " | k in 1..n-1])
];