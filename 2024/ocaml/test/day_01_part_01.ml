open OUnit2
open AoC_2024.Day_01.Part_01

let tests =
  "test suite for day 01 part 01"
  >::: [
         ("empty list is 0" >:: fun _ -> assert_equal 0 (solve [] []));
         ( "distance between 0 and 1 is 1" >:: fun _ ->
           assert_equal 1 (solve [ 0 ] [ 1 ]) );
         ( "distance between 1 and 0 is 1" >:: fun _ ->
           assert_equal 1 (solve [ 1 ] [ 0 ]) );
         ( "smallest are paired, then next smallest, ..." >:: fun _ ->
           assert_equal 0 (solve [ 1; 2; 3 ] [ 3; 2; 1 ]) );
         (* See https://adventofcode.com/2024/day/1 *)
         ( "solves example correctly" >:: fun _ ->
           assert_equal 11 (solve [ 3; 4; 2; 1; 3; 3 ] [ 4; 3; 5; 3; 9; 3 ]) );
         ( "same number is 0 distance apart" >:: fun _ ->
           assert_equal 0 (calculate_distance 0 0) );
         ( "same number is 0 distance apart" >:: fun _ ->
           assert_equal 0 (calculate_distance 1 1) );
         ( "distance is equal to abs(x - y)" >:: fun _ ->
           assert_equal 1 (calculate_distance 0 1) );
         ( "order of inputs doesn't matter" >:: fun _ ->
           assert_equal 1 (calculate_distance 1 0) );
       ]

let _ = run_test_tt_main tests
