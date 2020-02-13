structure Main : sig

  val main : unit -> int
  
end = struct

structure R = RegEx
structure D = Derivative
structure I = IO

val usage = foldr (fn (x, y)=> x^"\n"^y ) "" (IO.readlines("usage.txt"))

fun panic(msg) = 
  let
    val _ = print msg
  in
    OS.Process.exit(OS.Process.failure)
  end

fun unique(a, r) = 
  let
    val i = ref 0;
  in
    map (fn x => print(Int.toString((i := !i + 1; !i)) ^ ": " ^ R.tos(x) ^ "\n")) 
        (D.all(1, a, r, []))
  end

fun parseArgs([]) = (#" ", "", ~1, false)
  | parseArgs("-u"::args) = (case parseArgs(args) of (a, b, c, _) => (a, b, c, true))
  | parseArgs("-x"::a::args) = (case parseArgs(args) of (_, b, c, d) => (String.sub(a, 0), b, c, d))
  | parseArgs("-e"::b::args) = (case parseArgs(args) of (a, _, c, d) => (a, b, c, d))
  | parseArgs("-n"::c::args) = (case parseArgs(args) of (a, b, _, d) => (a, b, valOf (Int.fromString(c)), d))
  | parseArgs(_) = panic(usage)

fun validateArgs(a, r, n, u) = 
    if a = #" " 
       orelse r = "" 
       orelse (n = ~1 andalso u = false)
      then panic(usage)
    else ()

fun main() =
    let
      val args = CommandLine.arguments()
      val (a, r, n, u) = parseArgs args
      val _ = validateArgs(a, r, n, u)

      val parsed = Parse.parse(r)
      val r' = R.tos (D.nth(n, a, parsed))
      val _ = if u then () else print(r' ^ "\n")
      val _ = if u then unique(a, parsed) else []
  
    in
      OS.Process.exit(OS.Process.success)
    end

val _ = main()

end