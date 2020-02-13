structure Main : sig
  
  val main : unit -> int

end = struct

structure R = RegEx

val usage = foldr (fn (x, y)=> x^"\n"^y ) "" (IO.readlines("usage.txt"))

fun panic(msg) = 
  let
    val _ = print msg
  in
    OS.Process.exit(OS.Process.failure)
  end

fun parseArgs(r::nil) = r
  | parseArgs(_) = panic(usage)

fun main() =
    let
      val args = CommandLine.arguments()
      val r = parseArgs args

      val parsed = Parse.parse(r)
      val r' = R.tos (Reverse.reverse(parsed))
      val _ = print(r' ^ "\n")
  
    in
      OS.Process.exit(OS.Process.success)
    end

val _ = main()

end