let run_solver name solver filepath =
  let content = Infrastructure.File.read filepath in
  let answer = solver content () in
  Logs.app (fun m -> m "%s=%d" name answer)

let run_day = function
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
  | _ ->
      failwith "day not implemented"

let day_arg =
  let doc = "Day to run. MUST be in range of 1-12." in
  Cmdliner.Arg.(value & pos 0 int 1 & info [] ~docv:"DAY" ~doc)

let day_t = Cmdliner.Term.(const run_day $ day_arg)

let cmd =
  let info = Cmdliner.Cmd.info "aoc" ~version:"0.1.0" in
  Cmdliner.Cmd.v info day_t

let run () = Cmdliner.Cmd.eval' cmd
