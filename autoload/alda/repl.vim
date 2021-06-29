if !exists("g:alda_repl_server_info")
  let g:alda_repl_server_info = {}
endif

function! alda#repl#Connected()
  return has_key(g:alda_repl_server_info, "host") &&
        \ has_key(g:alda_repl_server_info, "port")
endfunction

function! alda#repl#RequireConnection() abort
  if !alda#repl#Connected()
    throw "Unspecified Alda REPL host/port. Use AldaConnect first."
  endif
endfunction

function! s:ReadPortFile() abort
  " This assumes that there is an .alda-nrepl-port file in the current
  " directory. readfile will print a useful error message if that file doesn't
  " exist, which is exactly what we would have done, anyway.
  return readfile(".alda-nrepl-port")[0]
endfunction

function! alda#repl#Connect(...) abort
  " TODO: Optionally recognize host in the argument, e.g. some.host:12345 or
  " just 12345 (i.e. localhost:12345). For now, we assume that you're just
  " giving us a port on localhost.
  let port = a:0 >= 1 ? a:1 : s:ReadPortFile()

  if port !~ '\v^\d+$'
    throw "Invalid port number: " . port
  endif

  let g:alda_repl_server_info.host = "localhost"
  let g:alda_repl_server_info.port = port
  echom "Alda REPL host/port set: " . string(g:alda_repl_server_info)
endfunction

function! alda#repl#Disconnect()
  let g:alda_repl_server_info = {}
  echom "Alda REPL host/port un-set."
endfunction

" Encodes msg (a Vimscript dictionary) as JSON and sends it as an nREPL message
" to the Alda REPL server, in an async job. Returns the job ID.
function! alda#repl#SendMessage(msg, ...) abort
  let Callback = (a:0 >= 1) ? a:1 : function('alda#StandardCallback')

  call alda#repl#RequireConnection()

  let cmd = alda#Command(
        \ "repl " .
        \ "--host " . g:alda_repl_server_info.host . " " .
        \ "--port " . g:alda_repl_server_info.port . " " .
        \ "--message " . shellescape(alda#json#stringify(a:msg))
        \ )

  return alda#RunAsync(cmd, Callback)
endfunction

function s:NewScoreCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let self.output += a:data
  elseif a:event == 'stderr'
    let output = trim(join(a:data, "\n"))
    if strlen(output) > 0
      echo output
    endif
  elseif a:event == 'exit'
    " If the exit code is non-zero, print the entire response for debugging
    " purposes.
    if a:data !=# 0 " exit code
      echo self.output
      return
    endif

    " Otherwise, the operation appears to have been successful, so print a nice
    " message for the user.
    echom "New score initialized."
  endif
endfunction

function! alda#repl#NewScore() abort
  return alda#repl#SendMessage(
        \ {"op": "new-score"},
        \ function("s:NewScoreCallback")
        \ )
endfunction

function s:ScoreTextCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let self.output += a:data
  elseif a:event == 'stderr'
    let output = trim(join(a:data, "\n"))
    if strlen(output) > 0
      echo output
    endif
  elseif a:event == 'exit'
    " If the exit code is non-zero, print the entire response for debugging
    " purposes.
    if a:data !=# 0 " exit code
      echo self.output
      return
    endif

    " Otherwise, the operation appears to have been successful, so print the
    " 'text' part of the JSON response.
    let output = trim(join(self.output, "\n"))
    echo alda#json#parse(output).text
  endif
endfunction

function! alda#repl#ScoreText() abort
  return alda#repl#SendMessage(
        \ {"op": "score-text"},
        \ function("s:ScoreTextCallback")
        \ )
endfunction

function s:PlayCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let self.output += a:data
  elseif a:event == 'stderr'
    let output = trim(join(a:data, "\n"))
    if strlen(output) > 0
      echo output
    endif
  elseif a:event == 'exit'
    " If the exit code is non-zero, print the entire response for debugging
    " purposes.
    if a:data !=# 0 " exit code
      echo self.output
      return
    endif

    " Otherwise, the operation appears to have been successful, so print a nice
    " message for the user.
    echom "Playing..."
  endif
endfunction

function! alda#repl#Play(input) abort
  return alda#repl#SendMessage(
        \ {"op": "eval-and-play", "code": a:input},
        \ function("s:PlayCallback")
        \ )
endfunction

function s:StopCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let self.output += a:data
  elseif a:event == 'stderr'
    let output = trim(join(a:data, "\n"))
    if strlen(output) > 0
      echo output
    endif
  elseif a:event == 'exit'
    " If the exit code is non-zero, print the entire response for debugging
    " purposes.
    if a:data !=# 0 " exit code
      echo self.output
      return
    endif

    " Otherwise, the operation appears to have been successful, so print a nice
    " message for the user.
    echom "Stopping playback."
  endif
endfunction

function! alda#repl#Stop() abort
  return alda#repl#SendMessage(
        \ {"op": "stop"},
        \ function("s:StopCallback")
        \ )
endfunction
