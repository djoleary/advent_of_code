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
    (fun y line ->
      String.iteri (fun x char -> matrix.(x).(y) <- Char.escaped char) line )
    lines ;
  matrix

(** [pp_matrix matrix] is the [input] that was used to create the [matrix]
    via [input_to_matrix input]. *)
let pp_matrix matrix =
  let row_count = Array.length matrix in
  let column_count = Array.length matrix.(0) in
  let matrix' = Array.make_matrix row_count column_count "" in
  Array.iteri
    (fun x row -> Array.iteri (fun y c -> matrix'.(y).(x) <- c) row)
    matrix ;
  matrix'
  |> Array.map @@ Array.fold_left (fun acc c -> acc ^ c) ""
  |> Array.fold_left
       (fun acc line -> if acc = "" then line else acc ^ "\n" ^ line)
       ""

let solve input () =
  let matrix = input |> input_to_matrix in
  Logs.debug (fun m -> m "\n%s" @@ pp_matrix matrix) ;
  0

let%expect_test "matrix created from input is pretty-printed as the same matrix"
    =
  let example =
    {|..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.|}
  in
  print_string @@ pp_matrix @@ input_to_matrix example ;
  [%expect
    {|..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.|}]

let%expect_test "direct access of the matrix is in form matrix.(x).(y)" =
  let example =
    {|..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.|}
  in
  let matrix = input_to_matrix example in
  print_string matrix.(0).(0) ;
  [%expect "."] ;
  print_string matrix.(1).(0) ;
  [%expect "."] ;
  print_string matrix.(2).(0) ;
  [%expect "@"] ;
  print_string matrix.(3).(0) ;
  [%expect "@"] ;
  print_string matrix.(4).(0) ;
  [%expect "."] ;
  print_string matrix.(5).(0) ;
  [%expect "@"] ;
  print_string matrix.(6).(0) ;
  [%expect "@"] ;
  print_string matrix.(7).(0) ;
  [%expect "@"] ;
  print_string matrix.(8).(0) ;
  [%expect "@"] ;
  print_string matrix.(9).(0) ;
  [%expect "."]
