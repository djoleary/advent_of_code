open Domain.D02p02

(* Logging *)

(** [passthrough_with_logs logger lst] is [lst] with the side-effects caused by calling [logger] on [lst]. *)
let passthrough_with_logs logger lst = logger lst ; lst

(** [input_to_lines input] is a list of strings that have been split on ','.
    Example: [input_to_lines "12-34,56-78,90-100"] becomes the list \[ "12-34"; "56-78"; "90-100" \].
    Requires: [input] to be a string in the format "12-34,56-78,90-100". *)
let input_to_lines input = input |> String.trim |> String.split_on_char ','

let pp_lines = Seq.iter (fun l -> Logs.debug (fun m -> m "line=%s" l))

let pp_ranges = Seq.iter (fun r -> Logs.debug (fun m -> m "%s" (Range.pp r)))

let pp_collection = Seq.iter (fun c -> Logs.debug (fun m -> m "%s" (ID.pp c)))

(* Core Logic *)

(** [lines_to_ranges line] is a list of [Range]s found on [line]. *)
let lines_to_ranges =
  Seq.map (fun line ->
      Scanf.sscanf line "%d-%d" (fun id1 id2 -> Range.create (id1, id2)) )

(** [collect_all ranges] is an unsorted list of [ID]s within the [ranges] (inclusive). *)
let collect_all =
  Seq.concat_map (fun range -> List.to_seq (Range.collect range))

(** [string_to_segments count string] is a list containing [count] string segments with of equal length.
    Requires: length of [string] to be divisible by [count]
    and [count] to be greater than or equal to zero *)
let rec string_to_segments s =
  let segment_lengths = possible_segment_lengths s in
  List.map (fun c -> string_to_segments_aux [] c s |> List.rev) segment_lengths

(** [possible_segment_lengths s] is a list of segment sizes that fit within [s]
    that must be checked to rule out a repeating pattern. *)
and possible_segment_lengths s =
  List.init (String.length s) (fun x -> x + 1)
  |> List.filter (fun x -> x != 1 && String.length s mod x = 0)

and string_to_segments_aux segments count string =
  match List.length segments = count with
  | true ->
      segments
  | false ->
      let segment_start = String.length string / count * List.length segments in
      let segment_len = String.length string / count in
      string_to_segments_aux
        (String.sub string segment_start segment_len :: segments)
        count string

(** [cmp_segments segments] is true is all segments are equal *)
let cmp_segments segments =
  List.length (List.sort_uniq String.compare segments) = 1

(** [is_invalid id] is [true] for an [id] that is considered invalid. *)
let is_invalid id =
  Logs.debug (fun m -> m "CHECKING ID=%s" id) ;
  let repeating_patterns =
    id |> string_to_segments |> List.filter cmp_segments
  in
  List.iter
    (fun l -> Logs.debug (fun m -> m "HAS SUBPATTERN=%s" (List.hd l)))
    repeating_patterns ;
  List.length repeating_patterns > 0

let solve input () =
  input |> input_to_lines |> List.to_seq
  |> passthrough_with_logs pp_lines
  |> lines_to_ranges
  |> passthrough_with_logs pp_ranges
  |> collect_all
  |> passthrough_with_logs pp_collection
  |> Seq.map ID.to_string |> Seq.filter is_invalid
  |> Seq.fold_left (fun acc id -> acc + int_of_string id) 0
