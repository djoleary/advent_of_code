module type Logger = sig
  val app : string -> unit

  val err : string -> unit

  val warn : string -> unit

  val info : string -> unit

  val debug : string -> unit
end
