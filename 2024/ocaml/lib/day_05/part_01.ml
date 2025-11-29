(* Day 5: Part 1 *)

module StringMap = Map.Make (String)

let inverse_page_rule page_rule =
  String.split_on_char '|' page_rule |> fun lst ->
  match lst with [] -> "" | _ :: _ -> String.concat "|" (List.rev lst)

(** [parse_aux acc page_rules] is a map of all invalid transitions as defined by
    [page_rules] *)
let rec get_invalid_transitions_aux acc page_rules : unit StringMap.t =
  match page_rules with
  | [] -> acc
  | h :: t ->
      get_invalid_transitions_aux
        (acc |> StringMap.add (inverse_page_rule h) ())
        t

let get_invalid_transitions page_rules =
  get_invalid_transitions_aux StringMap.empty page_rules

(** [solve page_rules updates] is the solution for this puzzle, given the
    [page_rules] and a list of [updates].

    BELOW DOESN'T WORK: no guarantee that second page comes immediately after
    the first
    - pass in updates to solve
    - make sliding window of 2 elements
    - invert element order and concat
    - check if key is in map from [parse page_rules],
    - if yes, then it is an illegal transition
    - if no, then add the list to a list for further processing *)
let solve page_rules _ =
  let invalid_transitions = get_invalid_transitions page_rules in
  ()

let _ =
  solve
    [
      "47|53";
      "97|13";
      "97|61";
      "97|47";
      "75|29";
      "61|13";
      "75|53";
      "29|13";
      "97|29";
      "53|29";
      "61|53";
      "97|53";
      "61|29";
      "47|13";
      "75|47";
      "97|75";
      "47|61";
      "75|61";
      "47|29";
      "75|13";
      "53|13";
    ]
    []
