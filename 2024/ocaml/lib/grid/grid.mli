val to_grid : string list -> int -> Cell.t option
(** The cell in the top left corner of the grid is returned where each element
    of [tokens] is converted into rows with [width]. An empty list of [tokens]
    returns None. Requires: [width] is greater than 0 **)

(* val print : Cell.t -> () *)
