open OUnit2
open AoC_2024.Day_04.Part_01

let example_input =
  [
    "MMMSXXMASM";
    "MSAMXMSMSA";
    "AMXSXMAAMM";
    "MSAMASMSMX";
    "XMASAMXAMM";
    "XXAMMXXAMA";
    "SMSMSASXSS";
    "SAXAMASAAA";
    "MAMMMXMMMM";
    "MXMXAXMASX";
  ]

let is_in_bounds_tests =
  let test_is_in_bounds expected length index _ =
    let actual = is_in_bounds length index in
    assert_equal ~printer:string_of_bool expected actual
  in
  [
    "not in bounds if below 0" >:: test_is_in_bounds false 1 (-1);
    "in bounds if gte 0 and lt length" >:: test_is_in_bounds true 1 0;
    "not in bounds if eq length" >:: test_is_in_bounds false 1 1;
    "not in bounds if gt length" >:: test_is_in_bounds false 1 2;
  ]

let calculate_num_of_matches_tests =
  let test_calculate_num_of_matches expected line row_offset character _ =
    let actual = calculate_num_of_matches line row_offset character in
    assert_equal ~printer:string_of_int expected actual
  in
  [
    "is 0 when no matches present"
    >:: test_calculate_num_of_matches 0 "SMMX" 1 { index = 3; character = 'X' };
    "is 1 when only one match present - top to bottom"
    >::
    (*
      |.|X|.|
      |.|M|.|
      |.|A|.|
      |.|S|.|
    *)
    test_calculate_num_of_matches 1 ".X..M..A..S." 3
      { index = 1; character = 'X' };
    "is 1 when only one match present - top to bottom edge"
    >::
    (*
      |X|.|.|
      |M|.|.|
      |A|.|.|
      |S|.|.|
    *)
    test_calculate_num_of_matches 1 "X..M..A..S.." 3
      { index = 0; character = 'X' };
    "is 1 when only one match present - bottom to top"
    >::
    (*
      |.|S|.|
      |.|A|.|
      |.|M|.|
      |.|X|.|
    *)
    test_calculate_num_of_matches 1 ".S..A..M..X." 3
      { index = 10; character = 'X' };
    "is 1 when only one match present - left to right"
    >::
    (*
      |X|M|A|S|
    *)
    test_calculate_num_of_matches 1 "XMAS" 4 { index = 0; character = 'X' };
    "is 1 when only one match present - right to left"
    >::
    (*
      |S|A|M|X|
    *)
    test_calculate_num_of_matches 1 "SAMX" 4 { index = 3; character = 'X' };
    "is 1 when only one match present - bottom right to top left"
    >::
    (*
      |S|.|.|.|
      |.|A|.|.|
      |.|.|M|.|
      |.|.|.|X|
    *)
    test_calculate_num_of_matches 1 "S....A....M....X" 4
      { index = 15; character = 'X' };
    "is 1 when only one match present - top left to bottom right"
    >::
    (*
      |X|.|.|.|
      |.|M|.|.|
      |.|.|A|.|
      |.|.|.|S|
    *)
    test_calculate_num_of_matches 1 "X....M....A....S" 4
      { index = 0; character = 'X' };
    "is 1 when only one match present - bottom left to top right"
    >::
    (*
      |.|.|.|S|
      |.|.|A|.|
      |.|M|.|.|
      |X|.|.|.|
    *)
    test_calculate_num_of_matches 1 "...S..A..M..X..." 4
      { index = 12; character = 'X' };
    "is 1 when only one match present - top right to bottom left"
    >::
    (*
      |.|.|.|X|
      |.|.|M|.|
      |.|A|.|.|
      |S|.|.|.|
    *)
    test_calculate_num_of_matches 1 "...X..M..A..S..." 4
      { index = 3; character = 'X' };
    "is 8 when matches present in all possible directions"
    >::
    (*
            |S|.|.|S|.|.|S|
            |.|A|.|A|.|A|.|
            |.|.|M|M|M|.|.|
            |S|A|M|X|M|A|S|
            |.|.|M|M|M|.|.|
            |.|A|.|A|.|A|.|
            |S|.|.|S|.|.|S|
    *)
    test_calculate_num_of_matches 8
      "S..S..S.A.A.A...MMM..SAMXMAS..MMM...A.A.A.S..S..S" 7
      { index = 24; character = 'X' };
  ]

let solve_tests =
  let test_solve expected lines _ =
    let actual = solve lines in
    assert_equal ~printer:string_of_int expected actual
  in
  [
    "example is solved correctly" >:: test_solve 18 example_input;
    "minimal example is solved correctly"
    >:: test_solve 4 [ "..X..."; ".SAMX."; ".A..A."; "XMAS.S"; ".X...." ];
  ]

let tests =
  "test suite for day 4 part 1"
  >::: is_in_bounds_tests @ calculate_num_of_matches_tests @ solve_tests

let _ = run_test_tt_main tests
