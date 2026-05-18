/*
SIMULA UN PRESTAMO DE 4 CUOTAS
LOS DATOS ESTAN APARTE, ARCHIVOS .dzn
Si lo ejecutas sin asociar el archivo de datos estara pensando eternamente!! (pk no hay parametros) si hubiesen parametros salta pop-up para poner los datos faltantes.
para asociar archivos de data, usar el project explorer. se pueden asignar diferetes var para responder diferentes preguntas con el mismo modelo.
*/


% variables
%var float: R;        %cuota a pagar
var 0..10000.0: R;
var float: P;        % principal initially borrowed
var 0.0 .. 2.0: I;   % interest rate

% intermediate variables
var float: B1; % balance after one quarter
var float: B2; % balance after two quarters
var float: B3; % balance after three quarters
var float: B4; % balance owing at end

constraint B1 = P * (1.0 + I) - R;
constraint B2 = B1 * (1.0 + I) - R;
constraint B3 = B2 * (1.0 + I) - R; 
constraint B4 = B3 * (1.0 + I) - R;

solve satisfy;

%show_float(0, 2, P) --> muestra float P con 2 decimales (y almenos 0 caracteres)
output [
 "Borrowing ", show_float(0, 2, P), " at ", show_float(0,2,I*100.0), 
 "% interest, and repaying ", show_float(0, 2, R), 
  "\nper quarter for 1 year leaves ", show_float(0, 2, B4), " owing\n"
];