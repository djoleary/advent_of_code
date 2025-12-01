let read filename =
  let chan = In_channel.open_text filename in
  let content = In_channel.input_all chan in
  In_channel.close chan ; content
