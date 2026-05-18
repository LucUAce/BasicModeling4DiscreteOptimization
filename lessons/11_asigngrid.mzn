/*
Assignment problem. poner prisioneros en celdas. separados hombres de mujeres, no prisioneros contiguos a los peligrosos, maximo uno por celda
*/

% cell block problem (2d model)
include "alldifferent.mzn";

enum PRISONER;

%definiendolo por filas y columnas es mas sencillo luego los constraints, que poniendo un array largo de todas la celdas!
int: n;  % number of rows in prison grid
set of int: ROW = 1..n;
int: m;  % number of columns in prison grid
set of int: COL = 1..m;

array[ROW,COL] of int: cost;
set of PRISONER: danger;
set of PRISONER: female;
set of PRISONER: male = PRISONER diff female;
%definir el conjunto de males no seria necesario, pero lo hace mas entendible

array[PRISONER] of var ROW: r;
array[PRISONER] of var COL: c;


%multiplicando las rows por el numero de columnas creamos un numero unico para cada celda!
constraint alldifferent([r[p]*m + c[p] | p in PRISONER]);

constraint forall (p in female) (r[p] <= ((n + 1) div 2));
constraint forall (p in male) (r[p] > ((n + 1) div 2));


% tiene que haber mas de uno de diferencia con los peligrosos (no contiguas, en diagonal si)
constraint forall (d in danger, p in PRISONER where d != p) ((abs(r[d] - r[p]) + abs(c[d] - c[p])) > 1);

var int: tCost = sum (p in PRISONER) (cost[r[p],c[p]]);
solve minimize tCost;

output["Female: "++show(p)++" in cell["++show(r[p])++","++show(c[p])++"]\n" | 
      p in female]
  ++ ["\n"]++["Male: "++show(p)++" in cell["++show(r[p])++","++show(c[p])++"]\n" | 
      p in male]
  ++ ["\nTotal Cost: ",show(tCost)];