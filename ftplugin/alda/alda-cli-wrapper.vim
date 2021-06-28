function! AldaCommands(ArgLead, CmdLine, CursorPos)
  " It might make sense to implement an internal command in Alda that lists all
  " available commands. Then we could shell out to get an accurate list of
  " available commands here, something like:
  "
  " return system("alda list-commands")
  return join(
        \ ["doctor", "export", "help", "instruments", "parse", "play", "ps",
        \ "repl", "shutdown", "stop", "telemetry", "update", "version"],
        \ "\n"
        \ )
endfunction

command! -nargs=* -complete=custom,AldaCommands
      \ Alda
      \ call alda#RunAsync(alda#Command(<q-args>))

nnoremap <buffer> <localleader>a
      \ :Alda<space>
