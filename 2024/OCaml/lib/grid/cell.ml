type t = {
  value : string;
  up : t option;
  down : t option;
  left : t option;
  right : t option;
}

let create value = { value; up = None; down = None; left = None; right = None }
let with_up up c = { c with up = Some up }
let with_down down c = { c with down = Some down }
let with_left left c = { c with left = Some left }
let with_right right c = { c with right = Some right }
let move_up co = match co with Some c -> c.up | None -> None
let move_down co = match co with Some c -> c.down | None -> None
let move_left co = match co with Some c -> c.left | None -> None
let move_right co = match co with Some c -> c.right | None -> None
let ( = ) c1 c2 = c1.value = c2.value
