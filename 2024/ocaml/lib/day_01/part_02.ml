(* Day 1: Part 2 *)

let rec count_occurrances_help element acc lst =
  match lst with
  | [] -> acc
  | h :: t ->
      if h = element then count_occurrances_help element (acc + 1) t
      else count_occurrances_help element acc t

let count_occurrances element lst = count_occurrances_help element 0 lst

let solve left right =
  List.map (fun x -> x * count_occurrances x right) left
  |> List.fold_left ( + ) 0

let left line =
  let pos = 0 in
  let len = String.index line ' ' in
  String.sub line pos len

let right line =
  let pos = String.rindex line ' ' + 1 in
  let len = String.length line - pos in
  String.sub line pos len

let line_to_tuple line = (left line, right line)

let lines_to_lists lines =
  let tuples = List.map line_to_tuple lines in
  let left =
    List.map
      (fun t ->
        let l, _ = t in
        int_of_string l)
      tuples
  in
  let right =
    List.map
      (fun t ->
        let _, r = t in
        int_of_string r)
      tuples
  in
  (left, right)
