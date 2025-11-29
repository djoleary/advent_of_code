let main () = Presentation.Cli.run ()

let () = if !Sys.interactive then () else exit (main ())
