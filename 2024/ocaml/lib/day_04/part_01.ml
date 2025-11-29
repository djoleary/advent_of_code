(* Day 4: Part 1 *)

type character = { index : int; character : char }
type direction = N | NE | E | SE | S | SW | W | NW

let all_directions = [ N; NE; E; SE; S; SW; W; NW ]
let needle = "XMAS"

(** [calculate_row_offset lines] is the offset used to move between the rows of
    the concatenated variant of [lines] as though it were a grid. Requires:
    values of [lines] all have the same length *)
let calculate_row_offset lines =
  match lines with [] -> 0 | h :: _ -> String.length h

let join_lines lines =
  let concat_trim acc line = acc ^ String.trim line in
  List.fold_left concat_trim "" lines

let explode s = List.init (String.length s) (String.get s)
let is_in_bounds length index = index >= 0 && index < length

let get_at_index line index =
  let length = String.length line in
  if not (is_in_bounds length index) then "."
  else
    let character = String.get line index in
    Char.escaped character

let get_direction_index row_offset direction index =
  match direction with
  | N -> index - row_offset
  | NE -> index - row_offset + 1
  | E -> index + 1
  | SE -> index + row_offset + 1
  | S -> index + row_offset
  | SW -> index + row_offset - 1
  | W -> index - 1
  | NW -> index - row_offset - 1

let get_direction_string get_char get_offset_index index =
  let first = get_char index in
  let second_index = get_offset_index index in
  let second = get_char second_index in
  let third_index = get_offset_index second_index in
  let third = get_char third_index in
  let fourth_index = get_offset_index third_index in
  let fourth = get_char fourth_index in
  first ^ second ^ third ^ fourth

let check_direction get_from_line get_offset_index index direction =
  get_direction_string get_from_line (get_offset_index direction) index = needle

let calculate_num_of_matches line row_offset character =
  let get_from_line_at_index = get_at_index line in
  let get_offset_direction_index = get_direction_index row_offset in
  let check_direction_from_index =
    check_direction get_from_line_at_index get_offset_direction_index
      character.index
  in
  all_directions
  |> List.map check_direction_from_index
  |> List.map (fun x -> match x with true -> 1 | false -> 0)
  |> List.fold_left ( + ) 0

(* Tried:
   2544 -> too high
   1272 (previous halved) -> too low *)
let solve lines =
  let row_offset = calculate_row_offset lines in
  let line = join_lines lines in
  let chars = explode line in
  let characters = List.mapi (fun i c -> { index = i; character = c }) chars in
  let xs =
    List.filter
      (fun c -> match c.character with 'X' -> true | _ -> false)
      characters
  in
  let calculate_num_of_surrounding_matches_in_line =
    calculate_num_of_matches line row_offset
  in
  let num_of_matches =
    List.map calculate_num_of_surrounding_matches_in_line xs
    |> List.fold_left ( + ) 0
  in
  num_of_matches
