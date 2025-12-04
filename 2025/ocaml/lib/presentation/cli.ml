(* Business logic behind CLI *)

let run_solver name solver filepath =
  let content = Infrastructure.File.read filepath in
  let answer = solver content () in
  Logs.app (fun m -> m "%s=%d" name answer)

let run_day _ = function
  | 1 ->
      let filepath = "../_input/day_01.txt" in
      run_solver "D01P01" Application.D01p01.solve filepath ;
      run_solver "D01P02" Application.D01p02.solve filepath ;
      0
  | 2 ->
      let filepath = "../_input/day_02.txt" in
      run_solver "D02P01" Application.D02p01.solve filepath ;
      run_solver "D02P02" Application.D02p02.solve filepath ;
      0
  | 3 ->
      let filepath = "../_input/day_03.txt" in
      run_solver "D03P01" Application.D03p01.solve filepath ;
      0
  | _ ->
      failwith "day not implemented"

(* Command line interface *)

open Cmdliner

let setup_log style_renderer = Fmt_tty.setup_std_outputs ?style_renderer ()

let setup_log_t = Term.(const setup_log $ Fmt_cli.style_renderer ())

let day_arg =
  let doc = "Day to run. MUST be in range of 1-12." in
  Arg.(value & pos 0 int 1 & info [] ~docv:"DAY" ~doc)

let day_t = Term.(const run_day $ setup_log_t $ day_arg)

let cmd =
  let info = Cmd.info "aoc" ~version:"0.1.0" in
  Cmd.v info day_t

let run () = Cmd.eval' cmd
