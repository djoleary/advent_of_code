open Cmdliner
open Cmdliner.Term.Syntax

let logger () =
  let env = Cmd.Env.info "LOG_LEVEL" in
  let+ level = Infrastructure.Logger.CLI_Logger.parse_level ~env
  and+ style_renderer = Fmt_cli.style_renderer () in
  Infrastructure.Logger.CLI_Logger.configure_logger ~level ;
  Fmt_tty.setup_std_outputs ?style_renderer () ;
  let result_code = 0 in
  result_code

let cmd = Cmd.v (Cmd.info "tool") @@ logger ()

let run () = Cmd.eval' cmd
