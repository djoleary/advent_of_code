module M : sig
  type t

  val of_string : string -> t option
  (** [of_string s] is a range of integers if [s] is a string in the form ["%d-%d"]
      or [None] otherwise. *)

  val collect : t -> int list
  (** [collect range] is a fully realised range as a list.
      Example: ["1-5" |> of_string |> collect] is the list [\[1;2;3;4;5\]].
      Example: ["5-1" |> of_string |> collect] is the list [\[5;4;3;2;1\]].*)

  val pp : t -> string
  (** [pp range] is a pretty-printed version of the range. *)
end = struct
  type t = int * int

  let of_string s =
    Scanf.sscanf_opt s "%d-%d" (fun start finish -> (start, finish))

  let rec collect (start, finish) =
    let collected =
      match Int.compare start finish with
      | -1 ->
          collect_range_aux Int.succ ( > ) [] (start, finish)
      | 0 ->
          [start]
      | 1 ->
          collect_range_aux Int.pred ( < ) [] (start, finish)
      | _ ->
          assert false
    in
    List.rev collected

  and collect_range_aux fn cmp lst (start, finish) =
    if cmp start finish then lst
    else collect_range_aux fn cmp (start :: lst) (fn start, finish)

  let pp (start, finish) = string_of_int start ^ "-" ^ string_of_int finish
end

let%expect_test "incrementing range" =
  match M.of_string "1-5" with
  | None ->
      [%expect.unreachable]
  | Some range ->
      let collected = M.collect range in
      List.iter print_int collected ;
      [%expect "12345"]

let%expect_test "decrementing range" =
  match M.of_string "5-1" with
  | None ->
      [%expect.unreachable]
  | Some range ->
      let collected = M.collect range in
      List.iter print_int collected ;
      [%expect "54321"]

let%expect_test "one element range" =
  match M.of_string "1-1" with
  | None ->
      [%expect.unreachable]
  | Some range ->
      let collected = M.collect range in
      List.iter print_int collected ;
      [%expect "1"]
