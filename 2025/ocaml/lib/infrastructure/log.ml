module LogsAdapter = struct
  type 'a t = ('a, unit) Logs.msgf

  let app msgf = Logs.app msgf

  let err msgf = Logs.err msgf

  let warn msgf = Logs.warn msgf

  let info msgf = Logs.info msgf

  let debug msgf = Logs.debug msgf
end

module Logger = Application.Logger.Make (LogsAdapter)
