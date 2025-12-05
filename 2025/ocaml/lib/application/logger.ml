module type LoggerType = sig
  type 'a t

  val app : 'a t -> unit

  val err : 'a t -> unit

  val warn : 'a t -> unit

  val info : 'a t -> unit

  val debug : 'a t -> unit
end

module type S = sig
  type 'a t

  val app : 'a t -> unit

  val err : 'a t -> unit

  val warn : 'a t -> unit

  val info : 'a t -> unit

  val debug : 'a t -> unit
end

module Make (Logger : LoggerType) : S with type 'a t := 'a Logger.t = struct
  let app = Logger.app

  let err = Logger.err

  let warn = Logger.warn

  let info = Logger.info

  let debug = Logger.debug
end
