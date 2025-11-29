open OUnit2
open AoC_2024.Day_02.Part_01

let tests =
  "test suite for day 2 part 1"
  >::: [
         ( "empty list should have no valid reports" >:: fun _ ->
           assert_equal 0 (solve []) );
         ( "valid report should count as one" >:: fun _ ->
           assert_equal 1 (solve [ [ 7; 6; 4; 2; 1 ] ]) );
         ( "example correct" >:: fun _ ->
           assert_equal 2
             (solve
                [
                  [ 7; 6; 4; 2; 1 ];
                  [ 1; 2; 7; 8; 9 ];
                  [ 9; 7; 6; 2; 1 ];
                  [ 1; 3; 2; 4; 5 ];
                  [ 8; 6; 4; 4; 1 ];
                  [ 1; 3; 6; 7; 9 ];
                ]) );
         ( "all increasing" >:: fun _ ->
           assert_equal true (check_report_safety [ 1; 2; 3 ]) );
         ( "all decreasing" >:: fun _ ->
           assert_equal true (check_report_safety [ 3; 2; 1 ]) );
         ( "increasing and decreasing" >:: fun _ ->
           assert_equal false (check_report_safety [ 1; 3; 2 ]) );
         ( "change of at least one" >:: fun _ ->
           assert_equal true (check_report_safety [ 1; 2; 3 ]) );
         ( "no change" >:: fun _ ->
           assert_equal false (check_report_safety [ 1; 1; 2 ]) );
         ( "change of at most three" >:: fun _ ->
           assert_equal true (check_report_safety [ 1; 2; 4; 7 ]) );
         ( "change of at more than three" >:: fun _ ->
           assert_equal false (check_report_safety [ 1; 5 ]) );
       ]

let _ = run_test_tt_main tests
