/*
distribuir platos en mesas. dish se mete con archivo de datos para poner mesas diferetes
*/

enum DISH;
int: capacity;
% vector con DISH elementos (como dish es un enum, es equivalente a un rango)
array[DISH] of int: satisf;
array[DISH] of int: size;

array[DISH] of var int: amt; % how many of each dish

% forall mete un constraint para cada valor de dish
constraint forall(i in DISH)(amt[i] >= 0);
% sum hace el sumatorio de todas las i en dish
constraint sum(i in DISH)(size[i] * amt[i]) <= capacity;
solve maximize sum(i in DISH)(satisf[i] * amt[i]);

% amt es un array, se postea como [2, 4, 12] 
output ["Amount = ", show(amt), "\n"];