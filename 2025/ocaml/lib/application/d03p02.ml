open Domain.D03p02

let err_empty_input = "input is empty"

let to_lines s =
  s |> String.split_on_char '\n' |> List.map String.trim
  |> List.filter (fun l -> l <> "")

let solve input () =
  if input = "" then Error err_empty_input
  else
    let answer =
      input |> to_lines |> List.to_seq
      |> Seq.map BatteryBank.of_string
      |> Seq.mapi (fun idx bb ->
          let joltage = BatteryBank.highest_joltage bb in
          Logs.debug (fun m ->
              m "%d line=%s highest_joltage=%d" (idx + 1) (BatteryBank.pp bb)
                joltage ) ;
          joltage )
      |> Seq.fold_left ( + ) 0
    in
    Ok answer
