type level = App | Err | Warning | Info | Debug

let log = function
  | App ->
      Logs.app
  | Err ->
      Logs.err
  | Warning ->
      Logs.warn
  | Info ->
      Logs.info
  | Debug ->
      Logs.debug

(** [pp_passthrough pp x] is [x] with the side-effects
    caused by calling [pp] on [x]. *)
let pp_passthrough pp x = pp x ; x

(** [pp_list lvl msg lst] prints all elements of [lst] with the
    message [msg] at the level [lvl] *)
let pp_list lvl msg = List.iter (fun elmt -> log lvl (fun m -> m msg elmt))

(** [pp_sequence lvl msg seq] prints all elements of [seq] with the
    message [msg] at the level [lvl] *)
let pp_sequence lvl msg = Seq.iter (fun elmt -> log lvl (fun m -> m msg elmt))
