let err_empty_input = "input is empty"

let solve input () = if input = "" then Error err_empty_input else Ok 0
