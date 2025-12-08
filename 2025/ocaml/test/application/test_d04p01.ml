open Application.D04p01

let example =
  {|..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.|}

let test_input_to_matrix have want () =
  Alcotest.(check int) "number of rolls of paper that are accessible" want
  @@ match solve have () with Error _ -> 0 | Ok ans -> ans

let () =
  let open Alcotest in
  run "D04p01"
    [ ( "given-example"
      , [test_case "full example" `Quick @@ test_input_to_matrix example 13] )
    ]
