structure RegEx = struct

datatype regex = Epsilon 
                | Phi
                | Symbol of char 
                | Or of regex * regex 
                | Concat of regex * regex 
                | Star of regex 

fun eq(Epsilon, Epsilon) = true
  | eq(Phi, Phi) = true
  | eq(Symbol a, Symbol b) = a = b
  | eq(Or(a1, a2), Or(b1, b2)) = eq(a1, b1) andalso eq(a2, b2)
  | eq(Concat(a1, a2), Concat(b1, b2)) = eq(a1, b1) andalso eq(a2, b2)
  | eq(Star(r1), Star(r2)) = eq(r1, r2)
  | eq(_, _) = false

fun tos (Epsilon) = "E" 
  | tos (Phi) = "P" 
  | tos (Symbol a) = str a 
  | tos (Or (R1, R2)) = "(" ^ tos(R1) ^ "+" ^ tos(R2) ^ ")"
  | tos (Concat (R1, R2)) = tos(R1) ^ tos(R2)
  | tos (Star (Symbol a)) = (str a) ^ "*" 
  | tos (Star R1) = "(" ^ tos(R1) ^ ")" ^ "*"

fun prune (Epsilon) = Epsilon 
    | prune (Phi) = Phi 
    | prune (Symbol a) = Symbol a  
 
    | prune (Or (R1, R2)) = 
      let
        val R1' = prune(R1)
        val R2' = prune(R2)
      in
        if R1' = Phi 
          then R2'
        else 
          if R2' = Phi 
            then R1'
          else 
            if R1' = Epsilon andalso R2' = Epsilon
              then Epsilon
            else
              if eq(R1', R2') 
                then R1'
              else 
                Or(R1', R2')
      end

    | prune (Concat (R1, R2)) = 
      let
        val R1' = prune(R1)
        val R2' = prune(R2)
      in
        if R1' = Epsilon 
          then R2' 
        else 
          if R2' = Epsilon 
            then R1'
          else 
            if R1' = Phi orelse R2' = Phi 
              then Phi
            else 
              if R1' = Epsilon andalso R2' = Epsilon 
                then Epsilon
              else 
                  Concat(R1', R2')
      end
   
    | prune (Star(Star(R1))) = prune(Star(prune(R1)))
    | prune (Star R1) =   
      let
        val R1' = prune(R1)
      in
        if R1' = Phi orelse R1' = Epsilon 
          then Epsilon
        else 
          Star(R1')
      end    

end