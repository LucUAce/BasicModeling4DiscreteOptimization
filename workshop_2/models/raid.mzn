% assignment 2
% select a set of raiding warrior
enum WARRIOR;
WARRIOR: dummy;
enum CLAN; % the clan they belong too

int: l; % minimum raid party size
int: u; % maximum raid party size
int: m; % limit of hatreds

array[WARRIOR] of int: strength;
array[WARRIOR] of CLAN: clan;

array[CLAN,CLAN] of 0..1: hates;

array[1..u] of var WARRIOR: araid;
var int: obj = sum(i in 1..u where araid[i] != dummy)(strength[araid[i]]);

constraint forall(i in 1..l)(araid[i] > dummy);

constraint forall(i in 1..u-1)(enum2int(araid[i]) >= enum2int(araid[i+1]) + (araid[i+1] != dummy));

constraint sum(i,j in 1..u where i < j)(hates[clan[araid[i]],clan[araid[j]]]) <= m;

solve maximize obj ;

set of WARRIOR: raid ::output_only =
{ fix(araid[i]) | i in 1..u where fix(araid[i]) != dummy };

output  ["raid = \(raid) \n obj = \(obj)\n"]