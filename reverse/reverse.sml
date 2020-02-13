structure Reverse : sig

    val reverse : RegEx.regex -> RegEx.regex

end = struct

structure R = RegEx

fun reverse (R.Phi) = R.Phi 
  | reverse (R.Epsilon) = R.Epsilon 
  | reverse (R.Symbol a) = R.Symbol a
  | reverse (R.Or (R1, R2)) = R.Or (reverse(R1), reverse(R2)) 
  | reverse (R.Concat (R1, R2)) = R.Concat (reverse(R2), reverse(R1)) 
  | reverse (R.Star R1) = R.Star (reverse(R1)) 

end