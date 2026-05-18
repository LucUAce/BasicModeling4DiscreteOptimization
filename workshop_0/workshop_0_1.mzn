% Use this editor as a MiniZinc scratch book
int: n;

array[1..n] of var 0..9: arr;
  
constraint sum(arr)= product(arr);
constraint forall(x in 1..n-1)( arr[x]<= arr[x+1]);

solve satisfy;

output "\(arr)";
