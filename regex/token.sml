structure Token = struct

datatype token = Symbol of char 
                | RParen 
                | LParen 
                | Plus 
                | Star
                | Epsilon
                | Phi

fun tos (Symbol a::ts) = (str a) ^ tos(ts)
  | tos (LParen::ts) = "(" ^ tos(ts)
  | tos (RParen::ts) = ")" ^ tos(ts)
  | tos (Plus::ts) = "+" ^ tos(ts)
  | tos (Star::ts) = "*" ^ tos(ts)
  | tos (Epsilon::ts) = "E" ^ tos(ts)
  | tos (Phi::ts) = "P" ^ tos(ts)
  | tos ([]) = ""

end