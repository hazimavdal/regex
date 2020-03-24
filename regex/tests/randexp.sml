use "../token.sml";
use "../regex.sml";
use "../scan.sml";
use "../parse.sml";
use "../utility.sml";
use "../range.sml";

structure R = RegEx
structure U = Utility

val alphabet = Range.crange(#"a", #"z")
val size = Range.len(alphabet)
val adist = Range.rep(1.0/Real.fromInt(size), size)
fun randSym() = U.choose(alphabet, adist)

val dist = [0.15, 0.15, 0.10, 0.2, 0.2, 0.2]

fun build 0 = R.Symbol (randSym())
  | build 1 = R.Epsilon
  | build 2 = R.Phi
  | build 3 = R.Or(randExpr(), randExpr())
  | build 4 = R.Concat(randExpr(), randExpr())
  | build 5 = R.Star(randExpr())
and randExpr() = build(U.choose([0,1,2,3,4,5], dist))

fun rands 0 = []
  | rands n = randExpr()::rands(n-1)

fun pr r = print(R.tos(r) ^ "\n")

fun show n = map pr (rands n)
