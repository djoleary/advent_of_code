let pp_range range =
  Logs.app (fun m -> m "range=%s" range) ;
  range

let pp_tuple tuple =
  let l, r = tuple in
  Logs.app (fun m -> m "(left=%s, right=%s)" l r) ;
  tuple

(** [input_to_ranges input] is a list of strings that have been split on ','.
    Requires: [input] to be a string in the format "12-34,56-78,90-100" *)
let input_to_ranges input =
  input |> String.split_on_char ','
  |> List.filter (fun range -> range <> "")
  |> List.map pp_range

let list_to_tuple = function
  | [l; r] ->
      (l, r)
  | _ ->
      failwith "list cannot convert to tuple"

let ranges_to_tuples ranges =
  ranges
  |> List.map (fun range ->
      let sides = String.split_on_char '-' range in
      list_to_tuple sides |> pp_tuple )

let solve input () =
  let _ = input |> input_to_ranges |> ranges_to_tuples in
  0
