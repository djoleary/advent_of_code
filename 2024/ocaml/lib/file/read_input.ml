let rec lines_from_channel ic =
  try
    let line = input_line ic in
    line :: lines_from_channel ic
  with End_of_file -> []

let lines_from_file filename =
  let channel = open_in filename in
  let lines = lines_from_channel channel in
  close_in channel;
  lines
