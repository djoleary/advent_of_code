module Battery : sig
  type t

  val of_int : int -> t

  val to_int : t -> int

  val to_string : t -> string

  val compare : t -> t -> int

  val pp : t -> string
end = struct
  type t = int

  let of_int i = i

  let to_int b = b

  let to_string = string_of_int

  let compare = Int.compare

  let pp = string_of_int
end

module BatteryBank : sig
  type t

  val highest_joltage : t -> int
  (** [highest_joltage bb] is an integer created from the two highest
      digits in [bb].
      Raises: [Assert_failure] if [bb] is empty. *)

  val of_string : string -> t

  val of_list : Battery.t list -> t

  val to_list : t -> Battery.t list

  val pp : t -> string
end = struct
  type t = Battery.t list

  let rec highest_joltage bb =
    assert (List.length bb > 0) ;
    match highest_joltage_aux (None, None) bb with
    | None, None ->
        0
    | Some x, Some y ->
        int_of_string (Battery.to_string x ^ Battery.to_string y)
    | _ ->
        failwith "highest_joltage must be two digits"

  and highest_joltage_aux acc = function
    | [] ->
        acc
    | [elt] -> (
      match acc with
      | None, None ->
          (Some (Battery.of_int 0), Some elt)
      | Some first, None ->
          (Some first, Some elt)
      | None, Some second ->
          (Some second, Some elt)
      | Some first, Some second ->
          if elt > second then (Some first, Some elt)
          else (Some first, Some second) )
    | h :: t ->
        highest_joltage_aux
          ( match acc with
          | None, None ->
              (Some h, None)
          | Some first, None ->
              let second = Battery.of_int 0 in
              swap_if_higher first second h
          | Some first, Some second ->
              swap_if_higher first second h
          | _ ->
              failwith "this branch should be impossible" )
          t

  and swap_if_higher first second considering =
    assert (first >= second) ;
    let c_gt_f = Battery.compare considering first = 1 in
    let c_gt_s = Battery.compare considering second = 1 in
    match (c_gt_f, c_gt_s) with
    | true, true ->
        (Some considering, None)
    | false, true ->
        (Some first, Some considering)
    | true, false ->
        failwith "[second] should never be greater than [first]"
    | false, false ->
        (Some first, Some second)

  let of_string s =
    s |> String.to_seq
    |> Seq.map (fun c -> Char.escaped c |> int_of_string |> Battery.of_int)
    |> List.of_seq

  let of_list lst = lst

  let to_list bb = bb

  let pp bb =
    "[ "
    ^ ( bb |> List.map Battery.pp
      |> List.fold_left
           (fun acc b ->
             if acc = "" then b ^ ";" else Printf.sprintf "%s %s;" acc b )
           "" )
    ^ " ]"
end
