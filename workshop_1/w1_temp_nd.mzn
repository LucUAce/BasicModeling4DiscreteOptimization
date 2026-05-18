/*
Calcula la temperatura del horno (la media de la temp anterior y la del exterior.), para luego ver que hay que hacer para mantener una buena temperatura, segun las acciones que hay disponibles.
*/ 
array[int] of int: readings;
int: n=length(readings);
int: start;
set of int: TIME0 = 0..n; 
set of int: TIME1 = 1..n; 

%mejor definir bien que valores tiene si se puede
array[TIME0] of var 25..30: temp;
constraint temp[0]= start;

enum CHOICES = {heat, strongly_heat, cool, strongly_cool, do_nothing};

% [] -> ordenado, fijo; {} -> conjunto desordenado.
array[CHOICES] of int: costs = [1, 5, 3, 9, 0];
array[CHOICES] of int: chtemp = [+1, +4, -2, -5, 0];

array[TIME1] of var CHOICES: choice;

constraint forall(i in TIME1)(temp[i] = ((temp[i-1] + readings[i]) div 2) + chtemp[choice[i]]);

var int: cost = sum(i in TIME1)(costs[choice[i]]);

solve minimize cost;

output ["temp = \(temp)\n choice = \(choice)\n cost = \(cost)"];

