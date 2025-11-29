open OUnit2
open AoC_2024.Day_03.Part_01

let example_input =
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

let test_find_mul _ =
  assert_equal
    [ "mul(2,4)"; "mul(5,5)"; "mul(11,8)"; "mul(8,5)" ]
    (let result = find_mul example_input in
     List.map (fun x -> Re2.Match.get_exn x ~sub:(`Index 0)) result)

let test_extract_pairs _ =
  assert_equal
    [ (2, 4); (5, 5); (11, 8); (8, 5) ]
    (let matches = find_mul example_input in
     extract_pairs matches)

let test_solve _ = assert_equal ~printer:string_of_int 161 (solve example_input)

let tests =
  "test suite for day 3 part 1"
  >::: [
         "muls extracted from example correctly" >:: test_find_mul;
         "pairs extracted from matches" >:: test_extract_pairs;
         "example correctly solved" >:: test_solve;
       ]

let _ = run_test_tt_main tests
