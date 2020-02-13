(*

ACKNOWLEDGEMENT: this file has been written by Professor Adam Shaw
from the University of Chicago and is taken from the course materials
for the Programming Languages Spring 2018 class.

http://people.cs.uchicago.edu/~adamshaw/cmsc22100-2018/index.html

*)

structure Check : sig

  (* check if two items are equal by built-in polymorphic equality *)
  val expect : ''a * ''a * string -> unit

  (* check if given boolean is true *)
  val assertT : bool * string -> unit

  (* check if given boolean is false *)
  val assertF : bool * string -> unit

  (* check if two items are equal by equality function *)
  val expectBy : ('a * 'a -> bool) * 'a * 'a * string -> unit

  (* check if the first item is among the list by built-in polymorphic equality *)
  val among : ''a * (''a list) * string -> unit

  (* check if the first item is among the list by equality function *)
  val amongBy : ('a * 'a -> bool) * 'a * ('a list) * string -> unit
                                                                   
  (* check if two floating-point values are within epsilon of another *)
  val within : real * real * real * string -> unit

  (* check if given delayed computation raises an exception *)
  val exn : ('a -> 'b) * 'a -> unit

end = struct

  fun msg s m = "Check." ^ s ^ " failure: " ^ m ^ "\n"

  fun assertT (b, m) =
    if b then () else raise Fail (msg "assertT" m)

  fun assertF (b, m) =
    if not b then () else raise Fail (msg "assertF" m)
                              
  fun expect (x, y, m) =
    if x=y then () else raise Fail (msg "expect" m)
                              
  fun expectBy (eq, x, y, m) =
    if eq(x,y) then () else raise Fail (msg "expectBy" m)

  fun among (x, ys, m) =
    let
      fun lp [] = raise Fail (msg "among" m)
        | lp (y::ys) = if x=y then () else lp ys
    in
      lp ys
    end
                                                      
  fun amongBy (eq, x, ys, m) =
    let
      fun lp [] = raise Fail (msg "amongBy" m)
        | lp (y::ys) = if eq(x,y) then () else lp ys
    in
      lp ys
    end

  fun within (eps:real, x, y, m) =
    if abs(x-y)<=eps then () else raise Fail (msg "within" m)
                                        
  fun exn (compute, arg) =
    let
      val x = SOME (compute arg) handle _ => NONE
    in
     (case x
        of NONE => ()
        |  SOME _ => raise Fail (""))
    end

end
