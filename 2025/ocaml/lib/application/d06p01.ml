let err_empty_input = "input is empty"

let log_matrix matrix =
  let open Domain.Matrix in
  Logs.debug (fun m -> m "%s" (M.of_list matrix |> M.pp (fun elt -> elt)))

let log_list lst =
  Logs.debug (fun m ->
      m "[%s]" (List.fold_left (fun acc i -> acc ^ i ^ "; ") " " lst) )

type operation = Mult | Add

let solve input () =
  if input = "" then Error err_empty_input
  else
    let input' = Parser.columns_of_string input in
    assert (input' <> []) ;
    log_matrix input' ;
    let nums =
      List.map (List.filter (fun i -> i <> "*" && i <> "+")) input'
      |> List.map
         @@ List.map (fun n ->
             Logs.debug (fun m -> m "peeking: %s" n) ;
             int_of_string n )
    and ops =
      List.map (List.filter (fun i -> i = "*" || i = "+")) input'
      |> List.concat
      |> List.map (fun op ->
          match op with
          | "*" ->
              Mult
          | "+" ->
              Add
          | _ ->
              failwith "case not covered" )
    in
    let answer =
      List.map2
        (fun op num_lst ->
          match op with
          | Add ->
              List.fold_left (fun acc i -> acc + i) 0 num_lst
          | Mult ->
              List.fold_left (fun acc i -> acc * i) 1 num_lst )
        ops nums
      |> fun lst ->
      log_list @@ List.map string_of_int lst ;
      lst |> List.fold_left ( + ) 0
    in
    Ok answer
