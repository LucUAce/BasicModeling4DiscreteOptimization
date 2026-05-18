/*
Modelo general para optimizar el PROFIT cuando produces PRODUCTS usando RESOURCES limitados o una CAPACITY limitada. 
La data incluye: 
                enum (array) PRODUCT de los productos que se pueden hacer;
                array profit indicando cuanto valor tiene cada producto;
                enum RESOURCE con los recursos que se utilizan para producir;
                array capacity si hay un maximo de productos que se pueden hacer;
                array 2D consumprion, indica cuanto resource se usa para producir cada product;
                (array produce para poner cuano se produce de cada product)
*/

enum PRODUCT;  
%elementos de un array pueden ser de cualquier tipo menos de array mismo (ahora es float)
% funcion length devuelve el tamaño de array 1D
array[PRODUCT] of int: profit; 
enum RESOURCE; 
array[RESOURCE] of int: capacity; 
 
/* Array comprehension
[expresion | generator1, generator2,...  (where test)]
[i+j| i in 1..3, j in 1..4 where i<j] 
eso genera un array [1+2, 1+3, 1+4, 2+3, 2+4, 3+4] = [3,4,5,5,6,7]
(si no le pones el where i<j, generaria un array del 2 al 12)  
*/

array[PRODUCT,RESOURCE] of int: consumption; 
/* Definir 2D array (dos maneras):

consumption = array2d(0..3., 0..3., 
              [ 1.5, 1.0, 1.0, 1.0,
                2.0, 0.0, 2.0, 0.0,
                1.5, 0.5, 1.0, 1.0, 
                0.5, 1.0, 0.9, 1.5,
                0.1, 2.5, 0.1, 2.5]);
hay arraynd hasta para n<= 6

consumption = [| 1.5, 1.0, 1.0, 1.0 
               | 2.0, 0.0, 2.0, 0.0
               | 1.5, 0.5, 1.0, 1.0 
               | 0.5, 1.0, 0.9, 1.5
               | 0.1, 2.5, 0.1, 2.5 |];
las | separan filas
*/

array[PRODUCT] of var int: produce;

% Must produce a non-negative amount
constraint forall(p in PRODUCT)
			   (produce[p] >= 0);

% Production can only use the available resources:
constraint forall (r in RESOURCE)(
 sum (p in PRODUCT)(consumption[p, r] * produce[p]) <= capacity[r]
); 

solve maximize sum(p in PRODUCT)   
                  (profit[p]*produce[p]);

output [ "\(p): \(produce[p])\n" | p in PRODUCT ]++["PROFIT: \(sum(p in PRODUCT)(profit[p]*produce[p]))"];