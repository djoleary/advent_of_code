open Domain.D01p01

let rec input_to_lines input =
  let lines =
    String.split_on_char '\n' input |> List.filter (fun l -> l <> "")
  in
  pp_lines lines ; lines

and pp_lines = function
  | [] ->
      ()
  | h :: t ->
      Logs.debug (fun m -> m "Line=%s" h) ;
      pp_lines t

let parse_line line =
  Scanf.sscanf line "%c%d" (fun d n ->
      match d with
      | 'L' ->
          Dial.Left n
      | 'R' ->
          Dial.Right n
      | _ ->
          failwith "invalid direction" )

let lines_to_turns =
  List.map (fun (l : string) ->
      Logs.debug (fun m -> m "parsing %s into turn" l) ;
      let turn = parse_line l in
      Logs.debug (fun m -> m "%s" (Dial.pp_direction turn)) ;
      turn )

let rec turn_aux count current = function
  | [] ->
      count
  | h :: t ->
      let current' = Dial.turn current h in
      Logs.debug (fun m -> m "dial at %d" (Dial.to_int current')) ;
      if Dial.to_int current' = 0 then turn_aux (count + 1) current' t
      else turn_aux count current' t

let turn current = turn_aux 0 current

let solve input () =
  let lines = input_to_lines input in
  let turns = lines_to_turns lines in
  let start = Dial.start in
  let answer = turn start turns in
  answer
