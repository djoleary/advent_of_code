let run_day = function
  | 1 ->
      let content = Infrastructure.File.read "../_input/day_01.txt" in
      let answerP1 = Application.D01p01.solve content () in
      Logs.app (fun m -> m "D1P1=%d" answerP1) ;
      let answerP2 = Application.D01p02.solve content () in
      Logs.app (fun m -> m "D1P2=%d" answerP2) ;
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
