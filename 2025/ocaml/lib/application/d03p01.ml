(** Day 3 Part 1
   Implementation Plan:

   For each line:
   1. Start with the tuple [(None, None)]
   2. Put the first two digits in the sequence into the tuple => [(Some m, Some n)]
   3. Walk the sequence
     - IF the digit in the sequence is greater than the first element of the tuple
       AND we are not looking at the last digit in the sequence,
         replace the first element of the tuple with that digit and set the other digit to None.
     - IF the digit in the sequence did not replace the first element of the tuple
       AND the digit is greater than the second element of the tuple,
        replace the second element of the tuple with that digit.
   4. Concat the elements of the tuple "string-wise" => [(Some m', Some n')] => [m' ^ n']
   5. Cast to int

   Sum the result of each line

   Tried: 17024 (hint: too low) - original
   Tried: 17061 (hint: too low) - fixed second digit promotion, e.g. "343411" would give 41 instead of 44
   Tried: 17081 (no hint given) - fixed second last digit promotion, e.g. "789" would give 79 insted of 89
   Tried: 17091 (no hint given) - no change but found diff of 10 in failing test case
   Tried: 17090 (no hint given) - no change but realised failing test case actually had a diff of 9 not 10 (have 56, want 65)
   Tried: 17099 (no hint given) - no change but found additional failing test case (have 67, want 76)

   Upper bound: 200 * 99 = 19800
 *)

open Domain.D03p01

let to_lines s =
  s |> String.split_on_char '\n' |> List.map String.trim
  |> List.filter (fun l -> l <> "")

let solve input () =
  input |> to_lines |> List.to_seq
  |> Seq.map BatteryBank.of_string
  |> Seq.mapi (fun idx bb ->
      let joltage = BatteryBank.highest_joltage bb in
      Logs.debug (fun m ->
          m "%d line=%s highest_joltage=%d" (idx + 1) (BatteryBank.pp bb)
            joltage ) ;
      joltage )
  |> Seq.fold_left ( + ) 0

let print_occurring_digits input () =
  input |> to_lines |> List.to_seq
  |> Seq.map BatteryBank.of_string
  |> Seq.map BatteryBank.to_list
  |> Seq.map (List.sort_uniq Battery.compare)
  |> Seq.map BatteryBank.of_list
  |> Seq.iteri (fun idx bb ->
      Logs.debug (fun m -> m "%d %s" (idx + 1) (BatteryBank.pp bb)) ) ;
  -1

[@@warning "-32"] (* disables unused function warning *)
let _solve' input () =
  let banks =
    input |> to_lines |> List.to_seq
    |> Seq.map BatteryBank.of_string
    |> Seq.map BatteryBank.to_list
    |> Seq.map (fun bb -> List.map Battery.to_int bb)
    |> List.of_seq
  in
  banks
