module Dial : sig
  (** [t] is a dial between 0 and 99 inclusive *)
  type t

  (** [direction] is a direction the dial can be turned *)
  type direction = Left of int | Right of int

  val start : t
  (** [start] is the initial state of the dial *)

  val dial_out_of_range : string
  (** [dial_out_of_range] is the error message when the dial is out of range *)

  val prev : t -> t

  val next : t -> t

  val is_zero : t -> bool

  val to_string : t -> string
  (** [to_string t] is the string representation of [t] *)

  val to_int : t -> int
  (** [to_int t] is the integer representation of [t] *)

  val pp_direction : direction -> string
end = struct
  (** [t] is an int between 0 and 99 inclusive *)
  type t = int

  type direction = Left of int | Right of int

  let start = 50

  let dial_out_of_range = "dial out of range"

  (** [next n] is the new state of the dial after turning [Right].
      Raises: [dial_out_of_range] if [n] is greater than 99. *)
  let next = function
    | n when n < 99 ->
        n + 1
    | 99 ->
        0
    | _ ->
        failwith dial_out_of_range

  (** [prev n] is the new state of the dial after turning [Left].
      Raises: [dial_out_of_range] if [n] is less than 0. *)
  let prev = function
    | n when n > 0 ->
        n - 1
    | 0 ->
        99
    | _ ->
        failwith dial_out_of_range

  let is_zero = function 0 -> true | _ -> false

  let to_string = string_of_int

  let to_int t = t

  let pp_direction = function
    | Left n ->
        "Left " ^ string_of_int n
    | Right n ->
        "Right " ^ string_of_int n
end

module Turner : sig
  val turn : Dial.t -> int -> Dial.direction -> Dial.t * int
  (** [turn dial direction] is the new state of the dial after turning [direction] on [dial] *)
end = struct
  (** [turn dial direction] is the new state of the dial after turning [direction] on [dial].
      Raises: [dial_out_of_range] if the dial is moved to an invalid state. *)
  let rec turn dial zero_count direction =
    let open Dial in
    match direction with
    | Left 0 ->
        (dial, zero_count)
    | Left n ->
        let dial' = prev dial in
        let zero_count' =
          if Dial.is_zero dial' then zero_count + 1 else zero_count
        in
        turn dial' zero_count' (Left (n - 1))
    | Right 0 ->
        (dial, zero_count)
    | Right n ->
        let dial' = next dial in
        let zero_count' =
          if Dial.is_zero dial' then zero_count + 1 else zero_count
        in
        turn dial' zero_count' (Right (n - 1))
end
