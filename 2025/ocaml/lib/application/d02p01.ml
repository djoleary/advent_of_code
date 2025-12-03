open Domain.D02p01

(** [input_to_lines input] is a list of strings that have been split on ','.
    Example: [input_to_lines "12-34,56-78,90-100"] becomes the list \[ "12-34"; "56-78"; "90-100" \].
    Requires: [input] to be a string in the format "12-34,56-78,90-100". *)
let input_to_lines input = input |> String.trim |> String.split_on_char ','

let pp_lines = List.iter (fun l -> Logs.debug (fun m -> m "line=%s" l))

(** [lines_to_ranges line] is a list of [Range]s found on [line]. *)
let lines_to_ranges =
  List.map (fun line ->
      Scanf.sscanf line "%d-%d" (fun id1 id2 -> Range.create (id1, id2)) )

let pp_ranges = List.iter (fun r -> Logs.debug (fun m -> m "%s" (Range.pp r)))

(** [collect_all ranges] is an unsorted list of [ID]s within the [ranges] (inclusive). *)
let collect_all = List.concat_map (fun range -> Range.collect range)

let pp_collection = List.iter (fun c -> Logs.debug (fun m -> m "%s" (ID.pp c)))

(** [rules] is a list of rules that [ID]s must pass to be considered invalid. *)
let rules =
  [ (fun id -> String.length (ID.to_string id) mod 2 = 0)
  ; (fun id ->
      let id' = ID.to_string id in
      let id_len = String.length id' in
      let left = String.sub id' 0 (id_len / 2) in
      let right = String.sub id' (id_len / 2) (id_len / 2) in
      String.equal left right ) ]

(** [is_invalid id] is [true] for an [id] that passes all of the rules and is considered invalid. *)
let is_invalid = ID.validate rules

(** [passthrough_with_logs logger lst] is [lst] with the side-effects caused by calling [logger] on [lst]. *)
let passthrough_with_logs logger lst = logger lst ; lst

let solve input () =
  input |> input_to_lines
  |> passthrough_with_logs pp_lines
  |> lines_to_ranges
  |> passthrough_with_logs pp_ranges
  |> collect_all
  |> passthrough_with_logs pp_collection
  |> List.filter is_invalid
  |> List.fold_left (fun acc id -> acc + ID.to_int id) 0
