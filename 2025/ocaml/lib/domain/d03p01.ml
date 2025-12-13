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

  val of_string : string -> t

  val of_list : Battery.t list -> t

  val to_list : t -> Battery.t list

  val pp : t -> string
end = struct
  type t = Battery.t list

  let rec highest_joltage bb =
    match highest_joltage_aux (None, None) bb with
    | None, None ->
        0
    | Some x, Some y ->
        int_of_string (Battery.to_string x ^ Battery.to_string y)
    | _ ->
        failwith "highest_joltage_aux must result in two digits"

  and highest_joltage_aux acc = function
    | [] ->
        acc
    | h :: t ->
        highest_joltage_aux
          ( match acc with
          | None, None ->
              (Some h, None)
          | Some first, None ->
              (Some first, Some h)
          | Some first, Some second ->
              swap_if_higher first second h (List.length t = 0)
          | _ ->
              failwith "this branch should be impossible" )
          t

  and swap_if_higher first second considering is_end =
    let c_gt_f = Battery.compare considering first = 1 in
    let c_gt_s = Battery.compare considering second = 1 in
    let f_gt_s = Battery.compare first second = 1 in
    if c_gt_f && c_gt_s && f_gt_s then
      if is_end then (Some first, Some considering) else (Some considering, None)
    else if (not c_gt_f) && c_gt_s && f_gt_s then (Some first, Some considering)
    else if c_gt_f && c_gt_s && not f_gt_s then
      if is_end then (Some second, Some considering)
      else (Some considering, None)
    else if (not c_gt_f) && (not c_gt_s) && f_gt_s then (Some first, Some second)
    else if c_gt_f && (not c_gt_s) && not f_gt_s then
      (Some second, Some considering)
    else (Some first, Some second)

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
