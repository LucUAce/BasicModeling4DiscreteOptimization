int: n; % number of court members
set of int: COURT = 1..n;
set of int: COURT0 = 0..n;
int: emperor = 1;
array[COURT] of int: rank;
array[COURT] of int: ability;

int: m; % number of horses
set of int: HORSE = 1..m;
set of int: HORSE0 = 0..m;
array[HORSE] of int: beauty;
array[HORSE] of int: speed;

array[COURT,HORSE] of int: enjoy;

array[HORSE] of var COURT0: rider; %caballos, que court tiene cada uno
array[COURT] of var HORSE0: horse; %court, q caballo tiene cada uno
var int: objective;

%CHANNELING rider - horse
constraint forall(i in HORSE)( rider[i] != 0 -> i = horse[rider[i]]);
constraint forall(i in COURT)( horse[i] != 0 -> i = rider[horse[i]]);

%diferente numero de court y horses
%else en vez de elseif m>n ---> All court members must ride unless there is no horse left available,
constraint if n>m then forall (i in HORSE)(rider[i] != 0) 
           else forall (i in COURT)(horse[i] !=0) endif;
       

%emperor mas joy q el resto
constraint forall(i in COURT where horse[i] != 0 /\ i != emperor)(enjoy[emperor, horse[emperor]] > enjoy[i, horse[i]]);


% If acourt member holds a higher rank than another,then either
% (a) the beauty of their horse can be no less than that assigned to the other,
% (b) the lower rank member does not ride, or
% (c) both court members do not ride.

constraint
forall(i, j in COURT where rank[i] > rank[j]) ( 
   (horse[i] = 0 /\ horse[j] = 0) \/
    horse[j] = 0 \/ 
   (horse[i] != 0 /\ beauty[horse[i]] >= beauty[horse[j]])
);

%THIS CONSTRAINT MIGH NOT HOLD WITH -100 penalty for each violation
var int: penalty;
constraint penalty >=0;
% If a horse is faster than another then either
% (a) the rider of the faster horse has no less riding ability than that of the slower horse,
% (b) the faster horse has no rider, or
% (c) both horses have no rider.

constraint penalty = sum(i, j in HORSE where speed[i] > speed[j]) ( not (
   (rider[i] = 0 /\ rider[j] = 0) \/
    rider[i] = 0 \/ 
   (rider[j] != 0 /\ ability[rider[i]] >= ability[rider[j]])));



constraint objective = sum(i in COURT where horse[i] != 0)(enjoy[i,horse[i]]) - penalty*100;

solve maximize objective;

output [" horse = \(horse) \n objective = \(objective)"];