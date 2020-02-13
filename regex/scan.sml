structure Scan : sig

  val scan : string -> Token.token list

end = struct

structure T = Token

fun nextToken [] = NONE 
    | nextToken (#"(" :: cs) = SOME(T.LParen, cs) 
    | nextToken (#")" :: cs) = SOME(T.RParen, cs) 
    | nextToken (#"+" :: cs) = SOME(T.Plus, cs) 
    | nextToken (#"*" :: cs) = SOME(T.Star, cs) 
    | nextToken (#"E" :: cs) = SOME(T.Epsilon, cs) 
    | nextToken (#"P":: cs) = SOME(T.Phi, cs)
    | nextToken (#" " :: cs) = nextToken cs
    | nextToken (a :: cs) = SOME(T.Symbol a, cs)

fun scan code =
  let
    fun lp [] = []
      | lp cs = case nextToken cs of
              SOME (tok, cs') => tok :: lp cs'
            | NONE => []
  in
    lp (explode code)
  end

end