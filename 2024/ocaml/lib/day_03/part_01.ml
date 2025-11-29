(* Day 3: Part 1 *)

let find_mul text =
  let regex_or_err = Re2.create "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)" in
  match regex_or_err with
  | Ok regex -> (
      let matches = Re2.get_matches regex text in
      match matches with Ok matches -> matches | Error _ -> [])
  | Error _ -> []

let extract_pairs (matches : Re2.Match.t list) : (int * int) list =
  List.map
    (fun x ->
      let left = Re2.Match.get x ~sub:(`Index 1) in
      match left with
      | None -> (0, 0)
      | Some left -> (
          let left_num = int_of_string left in
          let right = Re2.Match.get x ~sub:(`Index 2) in
          match right with
          | None -> (0, 0)
          | Some right ->
              let right_num = int_of_string right in
              (left_num, right_num)))
    matches

let solve input =
  input |> find_mul |> extract_pairs
  |> List.fold_left
       (fun acc pair ->
         let left, right = pair in
         acc + (left * right))
       0
