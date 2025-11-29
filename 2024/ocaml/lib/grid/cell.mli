type t = {
  value : string;
  up : t option;
  down : t option;
  left : t option;
  right : t option;
}

val create : string -> t
val with_up : t -> t -> t
val with_down : t -> t -> t
val with_left : t -> t -> t
val with_right : t -> t -> t
val move_up : t option -> t option
val move_down : t option -> t option
val move_left : t option -> t option
val move_right : t option -> t option
val ( = ) : t -> t -> bool
