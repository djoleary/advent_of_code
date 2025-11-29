open OUnit2
open AoC_2024.Day_01.Part_02

let test_solve =
  "test suite for day 01 part 02"
  >::: [
         ("empty list is 0" >:: fun _ -> assert_equal 0 (solve [] []));
         ( "ten x zero occurrances of ten" >:: fun _ ->
           assert_equal 0 (solve [ 10 ] [ 1; 2; 3 ]) );
         ( "two x three occurrances of two" >:: fun _ ->
           assert_equal 6 (solve [ 2 ] [ 2; 2; 2 ]) );
         (* See https://adventofcode.com/2024/day/1#part2 *)
         ( "solves example correctly" >:: fun _ ->
           assert_equal 31 (solve [ 3; 4; 2; 1; 3; 3 ] [ 4; 3; 5; 3; 9; 3 ]) );
       ]

let _ = run_test_tt_main test_solve
