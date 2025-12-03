module ID = struct
  (** *)
  type t = int

  let create num = num

  let validate rules id = List.fold_left (fun acc r -> acc && r id) true rules

  let incr = ( + ) 1

  let to_int id = id

  let to_string = string_of_int

  let pp id = "ID=" ^ string_of_int id
end

module Range = struct
  type t = ID.t * ID.t

  let create (id1, id2) = (ID.create id1, ID.create id2)

  let rec collect range = collect_range_aux [] range

  and collect_range_aux lst (id1, id2) =
    match id1 <= id2 with
    | false ->
        lst
    | true ->
        collect_range_aux (id1 :: lst) (ID.incr id1, id2)

  let pp (id1, id2) = "(L" ^ ID.pp id1 ^ ", R" ^ ID.pp id2 ^ ")"
end
