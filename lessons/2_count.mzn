/*
MIRA CUANTOS SOLDADOS HAY, SABIENDO CUANTOS SOBRAN CUANDO SE AGRUPAN EN 5,7,12 GRUPOS
*/

var 100..800: army;

%mod --> modulo
constraint army mod 5 = 2;
constraint army mod 7 = 2;
constraint army mod 12 = 1;

% satisfy no tiene variable objetivo.
% segun configuracion, para en 1er reultado que encuentra o calcula todos (-all-solutions)
% si no es satisfactible, saca un  ==UNSATISFIABLE==
solve satisfy;

%cuando no hay output, saca las variables que no se hayan asignado a nada