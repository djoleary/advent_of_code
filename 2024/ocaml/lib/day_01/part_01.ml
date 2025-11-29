(* Day 1: Part 1 *)

let calculate_distance x y = Stdlib.abs (x - y)

(** Require: left and right to be the same length *)
let solve left right =
  let sorted_left = List.sort Stdlib.compare left in
  let sorted_right = List.sort Stdlib.compare right in
  let distances = List.map2 calculate_distance sorted_left sorted_right in
  List.fold_left ( + ) 0 distances

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
