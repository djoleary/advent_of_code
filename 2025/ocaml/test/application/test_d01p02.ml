open Application.D01p02

let example_data = {|L68
L30
R48
L5
R60
L55
L1
L99
R14
L82|}

let test_full_given_example () =
  Alcotest.(check int) "full given example" 6 (solve example_data ())

let () =
  let open Alcotest in
  run "D01p02"
    [ ( "given-example"
      , [test_case "full given example" `Quick test_full_given_example] ) ]
