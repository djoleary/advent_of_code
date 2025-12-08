module M : sig
  type 'a t = 'a array array

  val empty : int -> int -> 'a -> 'a t
  (** [empty rows columns initial] is an empty 2D array of size [rows] * [columns]
      where each element in the array is initialized to [initial]. *)

  val of_list : 'a list list -> 'a t
  (** [of_list lst] is a 2D array where every element in the list is an element. *)

  val of_string : string -> string t
  (** [of_string str] is a 2D array where every character is an element. *)

  val get : 'a t -> int -> int -> 'a
  (** [get matrix x y] is an alias for [matrix.(y).(x)].
      Requires: [x] and [y] are positive integers or 0. *)

  val set : 'a t -> int -> int -> 'a -> unit
  (** [set matrix x y v] is an alias for [matrix.(y).(x) <- v].
      Requires: [x] and [y] are positive integers or 0. *)

  val get_valid_neighbours : 'a t -> int -> int -> (int * int) list
  (** [get_valid_neighbours matrix x y] is a list of pairs in the format
      (x * y) that represent the valid surrounding positions of [matrix.(y).(x)].
      Requires: [x] and [y] are positive integers or 0. *)

  val pp : ('a -> string) -> 'a t -> string
  (** [pp matrix string_of_elt] is the string representation of the [matrix]
      where [string_of_elt] is called on each element. *)
end = struct
  type 'a t = 'a array array

  let empty cols rows initial = Array.make_matrix cols rows initial

  let of_list lst = Array.of_list @@ List.map Array.of_list lst

  let of_string str =
    let lines =
      str |> String.split_on_char '\n'
      |> List.filter_map (fun line ->
          let trimmed = String.trim line in
          if trimmed <> "" then Some trimmed else None )
    in
    let char_lst =
      List.map
        (fun s -> s |> String.to_seq |> List.of_seq |> List.map Char.escaped)
        lines
    in
    of_list char_lst

  let get matrix x y = matrix.(y).(x)

  let set matrix x y v = matrix.(y).(x) <- v

  let get_valid_neighbours matrix x y =
    let potential_neighbours =
      [ (x - 1, y - 1)
      ; (x, y - 1)
      ; (x + 1, y - 1)
      ; (x - 1, y)
      ; (x + 1, y)
      ; (x - 1, y + 1)
      ; (x, y + 1)
      ; (x + 1, y + 1) ]
    in
    let min_x = 0 in
    let max_x = Array.length matrix.(y) - 1 in
    let min_y = 0 in
    let max_y = Array.length matrix - 1 in
    List.filter
      (fun (x, y) -> min_x <= x && x <= max_x && min_y <= y && y <= max_y)
      potential_neighbours

  let pp string_of_elt matrix =
    Array.fold_left
      (fun col_acc arr ->
        let row =
          Array.fold_left
            (fun row_acc elt -> row_acc ^ string_of_elt elt)
            "" arr
        in
        if col_acc = "" then row else col_acc ^ "\n" ^ row )
      "" matrix
end

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
  print_string @@ M.pp (fun s -> s) @@ M.of_string example ;
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

let%expect_test "direct access of the matrix is in form matrix.(y).(x)" =
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
  let matrix = M.of_string example in
  print_string matrix.(0).(0) ;
  [%expect "."] ;
  print_string matrix.(0).(1) ;
  [%expect "."] ;
  print_string matrix.(0).(2) ;
  [%expect "@"] ;
  print_string matrix.(0).(3) ;
  [%expect "@"] ;
  print_string matrix.(0).(4) ;
  [%expect "."] ;
  print_string matrix.(0).(5) ;
  [%expect "@"] ;
  print_string matrix.(0).(6) ;
  [%expect "@"] ;
  print_string matrix.(0).(7) ;
  [%expect "@"] ;
  print_string matrix.(0).(8) ;
  [%expect "@"] ;
  print_string matrix.(0).(9) ;
  [%expect "."]

let%expect_test "[M.get matrix x y] is an alias for [matrix.(y).(x)]" =
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
  let matrix = M.of_string example in
  print_string @@ M.get matrix 0 0 ;
  [%expect "."] ;
  print_string @@ M.get matrix 1 0 ;
  [%expect "."] ;
  print_string @@ M.get matrix 2 0 ;
  [%expect "@"] ;
  print_string @@ M.get matrix 3 0 ;
  [%expect "@"] ;
  print_string @@ M.get matrix 4 0 ;
  [%expect "."] ;
  print_string @@ M.get matrix 5 0 ;
  [%expect "@"] ;
  print_string @@ M.get matrix 6 0 ;
  [%expect "@"] ;
  print_string @@ M.get matrix 7 0 ;
  [%expect "@"] ;
  print_string @@ M.get matrix 8 0 ;
  [%expect "@"] ;
  print_string @@ M.get matrix 9 0 ;
  [%expect "."]
