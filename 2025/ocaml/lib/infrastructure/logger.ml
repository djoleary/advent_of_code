module type Configurable_Logger = sig
  include Application.Logger_sig.Logger

  val configure_logger : level:Logs.level option -> unit

  val parse_level :
    env:Cmdliner.Cmd.Env.info -> Logs.level option Cmdliner.Term.t

  val configure_renderer : style_renderer:Fmt.style_renderer option -> unit
end

module CLI_Logger : Configurable_Logger = struct
  let configure_logger ~level =
    Logs.set_level level ;
    Logs.set_reporter (Logs_fmt.reporter ())

  let parse_level ~env = Logs_cli.level ~env ()

  let configure_renderer ~style_renderer =
    Fmt_tty.setup_std_outputs ?style_renderer ()

  let app msg = Logs.app (fun m -> m "%s" msg)

  let err msg = Logs.err (fun m -> m "%s" msg)

  let warn msg = Logs.warn (fun m -> m "%s" msg)

  let info msg = Logs.info (fun m -> m "%s" msg)

  let debug msg = Logs.debug (fun m -> m "%s" msg)
end
