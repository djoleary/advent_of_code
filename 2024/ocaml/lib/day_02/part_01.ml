(* Day 2: Part 1 *)

type level = int
type reports = level list list

let rec compare_report_levels_helper comparison prev report =
  match report with
  | [] -> true
  | h :: t -> comparison prev h && compare_report_levels_helper comparison h t

let compare_report_levels comparison report =
  match report with
  | [] -> true
  | h :: t -> compare_report_levels_helper comparison h t

let all_increasing report = compare_report_levels ( < ) report
let all_decreasing report = compare_report_levels ( > ) report

let at_least_one report =
  compare_report_levels (fun prev curr -> prev <> curr) report

let at_most_three report =
  compare_report_levels (fun prev curr -> abs (prev - curr) <= 3) report

let check_report_safety report =
  if not (all_increasing report || all_decreasing report) then false
  else if not (at_least_one report && at_most_three report) then false
  else true

let rec count_safe_reports acc lst =
  match lst with
  | [] -> acc
  | h :: t ->
      if h then count_safe_reports (acc + 1) t else count_safe_reports acc t

let solve reports =
  reports |> List.map check_report_safety |> count_safe_reports 0

let line_to_report line =
  line |> String.split_on_char ' ' |> List.map int_of_string

let lines_to_reports lines = List.map line_to_report lines
