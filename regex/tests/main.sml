use "../../regex/token.sml";
use "../../regex/regex.sml";
use "../../regex/scan.sml";
use "../../regex/parse.sml";
use "../../util/check.sml";
use "../../util/io.sml";

val validExps = "examples/valid.txt" 
val invalidExps = "examples/invalid.txt" 

structure P = Parse
structure R = RegEx
structure C = Check

val exps =  IO.readlines(validExps)

val a = map P.parse exps
val b = map R.tos a
val aa = map P.parse b

fun test([], []) = ()
 | test(x::xs, y::ys) = 
    let
      val _ = print("\n A:>>>>>>>>>>> " ^ R.tos x)
      val _ = print("\n B:<<<<<<<<<<< " ^  R.tos y)
      val _ = C.expectBy(R.eq, x, y, "")
      val _ = test(xs, ys)
    in
      ()
    end
  | test(_) = raise Fail "The lists must be of equal length"

fun errs [] = ()
  | errs (x::xs) = C.exn(P.parse, x)

val _ = test(a, aa)
val _ = errs(IO.readlines(invalidExps))

val _ = print "So long, and thanks for all the fish."