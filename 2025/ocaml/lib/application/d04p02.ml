open Domain

let err_empty_input = "input is empty"

let rec count_accessible_rolls matrix =
  let count_paper lst = List.length @@ List.filter (fun c -> c <> ".") lst in
  let accessible_rolls_of_paper = ref 0 in
  count_accessible_rolls_aux matrix count_paper accessible_rolls_of_paper ;
  !accessible_rolls_of_paper

and count_accessible_rolls_aux matrix count_paper accessible_rolls_of_paper =
  for y = 0 to Array.length matrix - 1 do
    for x = 0 to Array.length matrix.(y) - 1 do
      if matrix.(y).(x) = "." then ()
      else
        let neighbour_coords = Matrix.M.get_valid_neighbours matrix x y in
        let neighbours =
          List.map (fun (x', y') -> Matrix.M.get matrix x' y') neighbour_coords
        in
        let paper_count = count_paper neighbours in
        let is_accessible = paper_count < 4 in
        if is_accessible then
          accessible_rolls_of_paper := !accessible_rolls_of_paper + 1 ;
        print_iteration_debug_msg x y neighbour_coords neighbours paper_count
          is_accessible
    done
  done

and print_iteration_debug_msg x y neighbour_coords neighbours paper_count
    is_accessible =
  Logs.debug (fun m ->
      m
        "coords=(%d,%d) neighbour_coords=[%s] neighbours=[%s] paper=%d \
         is_accessible=%B"
        x y
        (List.fold_left
           (fun acc (x, y) ->
             if acc = "" then
               " (" ^ string_of_int x ^ "," ^ string_of_int y ^ "); "
             else acc ^ "(" ^ string_of_int x ^ "," ^ string_of_int y ^ "); " )
           "" neighbour_coords )
        (List.fold_left
           (fun acc neighbour ->
             if acc = "" then " " ^ neighbour ^ "; " else acc ^ neighbour ^ "; " )
           "" neighbours )
        paper_count is_accessible )

let solve input () =
  if input = "" then Error err_empty_input
  else
    let matrix = Matrix.M.of_string input in
    let accessible_rolls_of_paper = count_accessible_rolls matrix in
    Ok accessible_rolls_of_paper
