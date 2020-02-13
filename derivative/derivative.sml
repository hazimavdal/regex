structure Derivative : sig

    val nth : int * char * RegEx.regex -> RegEx.regex
    val first : char * RegEx.regex -> RegEx.regex
    val all : int * char * RegEx.regex * RegEx.regex list-> RegEx.regex list

end = struct

structure R = RegEx
structure P = Parse

fun nullable(R.Epsilon) = R.Epsilon 
  | nullable(R.Phi) = R.Phi 
  | nullable(R.Symbol _) = R.Phi 
  | nullable(R.Or(R1, R2)) = R.Or(nullable(R1), nullable(R2)) 
  | nullable(R.Concat(R1, R2)) = R.Concat(nullable(R1), nullable(R2)) 
  | nullable(R.Star(_)) = R.Epsilon

fun brzozowski(a, R.Symbol a') = if a = a' then R.Epsilon else R.Phi 
  | brzozowski(_, R.Epsilon) = R.Phi  
  | brzozowski(_, R.Phi) = R.Phi 
  | brzozowski(a, R.Or (R1, R2)) = R.Or(brzozowski(a, R1), brzozowski(a, R2))  

  | brzozowski(a, R.Concat (R1, R2)) = R.Or(R.Concat(brzozowski(a, R1), R2), 
                                            R.Concat(nullable(R1), 
                                                     brzozowski(a, R2))) 

  | brzozowski(a, R.Star(R1)) = R.Concat(brzozowski(a, R1), R.Star (R1))

fun nth(0, a, r) = R.prone(r)
  | nth(n, a, r) = nth(n-1, a, brzozowski(a, r)) 

fun first (a, r) = nth(1, a, r)

infix isin
fun r isin [] = false
  | r isin (x::xs) = R.eq(r, x) orelse r isin xs

fun all(n, a, r, l) = 
    let
      val d = nth(n, a, r)

    in
      if d isin l then l
        else all(n+1, a, r, d::l)
    end

end