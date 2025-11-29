let rec to_grid_aux tokens max_width acc =
  match tokens with
  | [] -> acc
  | h :: t ->
      let new_cell = Cell.create h |> Cell.with_left acc in
      let new_acc = acc |> Cell.with_right new_cell in
      to_grid_aux t max_width new_acc

let to_grid tokens max_width : Cell.t option =
  match tokens with
  | [] -> None
  | h :: t ->
      let first_cell = Cell.create h in
      Some (to_grid_aux t max_width first_cell)
