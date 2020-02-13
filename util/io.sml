structure IO : sig
  
  val readlines : string -> string list

end = struct

fun readlines (file) = 
    let 

    val ins = TextIO.openIn file 

    fun lp ins = 
        case TextIO.inputLine ins of 
            SOME (line) => substring(line, 0, size(line)-1)::lp ins 
            | NONE => [] 

    in 
        lp ins before TextIO.closeIn ins 
    end 


end