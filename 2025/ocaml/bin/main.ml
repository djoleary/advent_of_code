let env_log_level =
  match Sys.getenv_opt "LOG_LEVEL" with
  | None ->
      Some Logs.Warning
  | Some lvl -> (
    match Logs.level_of_string lvl with Error _ -> None | Ok v -> v )

let main () =
  let log_level = env_log_level in
  Logs.set_level log_level ;
  Logs.set_reporter (Logs_fmt.reporter ()) ;
  Logs.info (fun m ->
      m "Started application with LOG_LEVEL=%s" (Logs.level_to_string log_level) ) ;
  Presentation.Cli.run ()

let () = if !Sys.interactive then () else exit (main ())
