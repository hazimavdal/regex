structure Parse : sig

  val parse : string -> RegEx.regex

end = struct

structure R = RegEx
structure T = Token

exception SyntaxError of string

  fun doparse ts =
      let
          val (r, ts') = term ts
      in
          case ts'
            of (T.Plus::ts'') =>
               let
                   val (r', ts''') = doparse ts''
               in
                   (R.Or (r, r'), ts''')
               end
             | _ => (r, ts')
      end

  and term ts =
      let
          val (r, ts') = kleene ts
      in
          case ts'
            of (nil) => (r, ts')
             | (T.Plus::ts'') => (r, (T.Plus::ts''))
             | (T.RParen::ts'') => (r, (T.RParen::ts''))
             | _ =>
               let
                   val (r', ts'') = term ts'
               in
                   (R.Concat (r, r'), ts'')
               end
      end

  and kleene ts =
      let
          val (r, ts') = atomic ts
      in
          case ts'
            of (T.Star :: T.Star :: ts'') => (R.Star r, ts'') (* a** is legal *)
             | (T.Star :: ts'') => (R.Star r, ts'')
             | _ => (r, ts')
      end

  and atomic [] = (R.Phi, [])
    | atomic ((T.Phi) :: ts) = (R.Phi, ts)
    | atomic ((T.Epsilon) :: ts) = (R.Epsilon, ts)
    | atomic ((T.Symbol a) :: ts) = (R.Symbol a, ts)
    | atomic (T.LParen::T.RParen:: ts) = (R.Phi, ts)
    | atomic (T.LParen :: ts) =
      let
          val (r, ts') = doparse ts
      in
          case ts'
            of nil => raise SyntaxError ("Expected closing-parenthesis\n")
             | (T.RParen :: ts'') => (r, ts'')
             | _ => raise SyntaxError ("Expected closing-parenthesis\n")
      end

    | atomic ts = raise SyntaxError ("Unexpected " ^ T.tos ts) 


fun parse r = case doparse(Scan.scan r) of 
                        (R, []) => R
                      | (_, ts) => raise SyntaxError ("Tokens after main expression " ^ (T.tos ts))


end