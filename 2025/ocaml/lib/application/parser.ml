(** [rows_of_string s] is a list of strings where each element is a row of [s]. *)
let rows_of_string s =
  s |> String.split_on_char '\n'
  |> List.filter_map (fun l ->
      let trimmed = String.trim l in
      if trimmed <> "" then Some trimmed else None )

(** [columns_of_string ?sep s] is a list of strings where each element is
    a column of [s] where each column is separated by [sep]. *)
let rec columns_of_string ?(sep = ' ') s =
  rows_of_string s
  |> List.map (fun l ->
      l |> String.split_on_char sep |> List.filter (fun l -> l <> "") )
  |> transpose

(** [group_columns lst] is a list where the first element of each
    sublist of [lst] is grouped in [acc] and so on for the rest of the elements.
    Example: [group_columns [] \[\["abc"; "def"\]; \["ghi"; "jkl"\]\]] is the list [\[\["abc";"ghi"\];\["def";"jkl"\]\]]. *)
and transpose lst =
  assert (lst <> []) ;
  if List.mem [] lst then []
  else List.map List.hd lst :: transpose (List.map List.tl lst)

let%expect_test "rows correctly parsed" =
  let have = {| abc def
    ghi jkl |} in
  let rows = rows_of_string have in
  List.iter (fun c -> print_string (c ^ " ")) rows ;
  [%expect {| abc def ghi jkl |}]

let%expect_test "columns correctly parsed" =
  let have = {| abc def
    ghi jkl |} in
  let cols = columns_of_string have in
  List.iter (fun row -> List.iter (fun c -> print_string (c ^ " ")) row) cols ;
  [%expect {| abc ghi def jkl |}]
