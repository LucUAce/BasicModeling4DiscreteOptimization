/*
biyeccion vino - comida. usar las dos funciones para facilitar si hay constraints donde expresarlo con una funcion lo hace mas facil que con la otra
*/

enum FOOD;
enum WINE;
array[FOOD, WINE] of int: joy;

array[FOOD] of var WINE: drink;
%constraint alldifferent(drink);

array[WINE] of var FOOD: eat;
%constraint alldifferent(eat);

%inverse dice que eat y drink forman una biyeccion. (indirectamente tmb dice que todos sus elementos son diferentes)
%eat[w] = f <=> drink[f] = w
include "globals.mzn";
constraint inverse(eat, drink);

% solve maximize sum (f in FOOD) (joy[f, drink[f]]);
solve maximize sum (w in WINE) (joy[eat[w], w]);
output["Pair Food \(f) with Wine \(drink[f])\n" | f in FOOD] ++ ["\nJoy: \(sum(f in FOOD)(joy[f, drink[f]]))"];