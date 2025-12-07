let solve input () =
  let matrix = Domain.Matrix.M.of_string input in
  Logs.debug (fun m -> m "\n%s" @@ Domain.Matrix.M.pp (fun s -> s) matrix) ;
  0
