var 1..9: S;
var 0..9: E;
var 1..9: V;
var 0..9: N;
var 1..9: P;
var 0..9: A;
var 0..9: C;
var 0..9: R;

var int: VERSE =  10000 * V + 1001 * E + 100 * R + 10*S;
constraint
           10001 * S + 1020 * E + 100 * V + N
         + 10000 * P + 1000 * A + 100 * C 
         = VERSE;

include "alldifferent.mzn";
constraint alldifferent([S,E,V,N,P,A,R,C]);

solve maximize VERSE;

output
["  \(S) \(E) \(V) \(E) \(N)\n" ++
 "+ \(P) \(A) \(C) \(E) \(S)\n" ++
 "--------------------------\n" ++
 "= \(V) \(E) \(R) \(S) \(E)\n"];