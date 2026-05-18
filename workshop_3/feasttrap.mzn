% Beauty Trap
% Create the most magnificient feast 
enum DISH;
enum TASTE = {spicy, sour, salty, sweet, umame, bland};
enum TEMP = {hot, cold, warm};

%int: ndish;
%set of int: DISH = 1..ndish;
%set of int: TASTE = 1..6;
%int: spicy = 1; int: sour = 2; int: salty = 3; int: sweet = 4; int: umame = 5; int: bland = 6;
%set of int: TEMP = 1..3;
%int: hot = 1; int: cold = 2; int: warm = 3;

array[DISH] of TASTE: taste;
array[DISH] of TEMP: temp;
array[DISH] of bool: heavy;
array[DISH] of int: value;

int: len; % length of banquet
set of int: COURSE = 1..len;
set of int: COUR1 = 1..len-1;

array[COURSE] of var DISH: dish;

var int: obj= sum(i in COURSE)(value[dish[i]])+ 
   %                   sum(i in 1..COUR1)(taste[dish[i]] != taste[dish[i+1]]) +    taste cambia siempre, so is =len-1
                      len-1 +
                      sum(i in COUR1)(temp[dish[i]] != temp[dish[i+1]]) +
                      sum(i in COUR1)(heavy[dish[i]] != heavy[dish[i+1]]);

include "alldifferent.mzn";
constraint alldifferent(dish);

%constraint taste:
constraint forall (i in COUR1)(taste[dish[i]] != taste[dish[i+1]]);
constraint taste[dish[1]] = salty /\ taste[dish[len]] = sweet;
constraint forall (i in COUR1)(taste[dish[i]]= spicy -> (taste[dish[i+1]]=bland \/ taste[dish[i+1]]=sweet));
constraint forall (i in COUR1)(taste[dish[i]]= sour -> (taste[dish[i+1]]=bland \/ taste[dish[i+1]]=umame));
constraint forall (i in COUR1)((taste[dish[i+1]]=spicy \/ taste[dish[i+1]]=umame) -> taste[dish[i]] != sweet );

%constraint temp
constraint forall (i in COUR1)(temp[dish[i]]= hot ->
 (forall(j in i+1..len)(temp[dish[j]] = cold -> exists(k in i+1..j-1)(temp[dish[k]] = warm))));
%o poner que si i es hot, i+1 no puede ser cold!!

%constraint heavy
constraint forall (i in 1..len-2)((heavy[dish[i]]/\heavy[dish[i+1]]) -> not heavy[dish[i+2]]);

solve maximize obj;

output ["dish = \(dish) \n obj = \(obj)\n"]