open Domain.D01p02

let test_start () =
  Alcotest.(check int) "incorrect starting state" 50 (Dial.to_int Dial.start)

let test_turn errmsg exp dir =
  Alcotest.(check int)
    errmsg exp
    (Dial.to_int (fst (Turner.turn Dial.start 0 dir)))

let test_turn_left_one () =
  test_turn "incorrect result when turning left one step" 49 (Dial.Left 1)

let test_turn_left_100 () =
  test_turn "incorrect result when turning left 100 steps" 50 (Dial.Left 100)

let test_turn_right_one () =
  test_turn "incorrect result when turning right one step" 51 (Dial.Right 1)

let test_turn_right_100 () =
  test_turn "incorrect result when turning right 100 steps" 50 (Dial.Right 100)

let test_zero_count errmsg exp dir =
  Alcotest.(check int) errmsg exp (snd (Turner.turn Dial.start 0 dir))

let test_zero_count_right_1000 () =
  test_zero_count "zero MUST be counted each time it is passed" 10
    (Dial.Right 1000)

let () =
  let open Alcotest in
  run "D01p02"
    [ ("initial-state", [test_case "starting state" `Quick test_start])
    ; ( "turning-dial-regression"
      , [ test_case "turning left one step" `Quick test_turn_left_one
        ; test_case "turning right one step" `Quick test_turn_right_one
        ; test_case "turning left 100 steps" `Quick test_turn_left_100
        ; test_case "turning right 100 steps" `Quick test_turn_right_100 ] )
    ; ( "zero-count"
      , [ test_case "zero count after turning right 1000 steps" `Quick
            test_zero_count_right_1000 ] ) ]
