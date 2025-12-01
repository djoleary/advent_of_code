open Domain.D01p01

let test_start () =
  Alcotest.(check int) "incorrect starting state" 50 (Dial.to_int Dial.start)

let test_turn desc exp dir =
  Alcotest.(check int) desc exp (Dial.to_int (Dial.turn Dial.start dir))

let test_turn_left_one () =
  test_turn "incorrect result when turning left one step" 49 (Dial.Left 1)

let test_turn_left_100 () =
  test_turn "incorrect result when turning left 100 steps" 50 (Dial.Left 100)

let test_turn_right_one () =
  test_turn "incorrect result when turning right one step" 51 (Dial.Right 1)

let test_turn_right_100 () =
  test_turn "incorrect result when turning right 100 steps" 50 (Dial.Right 100)

let () =
  let open Alcotest in
  run "Day_1"
    [ ("initial-state", [test_case "starting state" `Quick test_start])
    ; ( "turning-dial"
      , [ test_case "turning left one step" `Quick test_turn_left_one
        ; test_case "turning right one step" `Quick test_turn_right_one
        ; test_case "turning left 100 steps" `Quick test_turn_left_100
        ; test_case "turning right 100 steps" `Quick test_turn_right_100 ] ) ]
