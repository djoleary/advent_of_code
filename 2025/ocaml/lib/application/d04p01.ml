(** [input_to_matrix input] is a 2D Array where each line of the [input] is
    a row and each character in that line is a column.
    Requires: all lines in input are of equal length. *)
let input_to_matrix input =
  let lines =
    input |> String.split_on_char '\n'
    |> List.filter_map (fun line ->
        let trimmed = String.trim line in
        if trimmed <> "" then Some trimmed else None )
  in
  let row_count = List.length lines in
  let column_count =
    match List.nth_opt lines 1 with
    | None ->
        failwith "first line should not be empty"
    | Some line ->
        String.length line
  in
  let matrix = Array.make_matrix column_count row_count "" in
  List.iteri
    (fun x line ->
      String.iteri (fun y char -> matrix.(x).(y) <- Char.escaped char) line )
    lines ;
  matrix

let pp_matrix matrix =
  "[\n"
  ^ ( matrix
    |> Array.map @@ Array.fold_left (fun acc c -> acc ^ c) ""
    |> Array.fold_left
         (fun acc line ->
           if acc = "" then "  [" ^ line ^ "]" else acc ^ "\n  [" ^ line ^ "]" )
         "" )
  ^ "\n]"

let solve input () =
  let matrix = input |> input_to_matrix in
  Logs.debug (fun m -> m "%s" @@ pp_matrix matrix) ;
  0
