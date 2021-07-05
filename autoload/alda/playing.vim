function! alda#playing#PlayDisconnected(input) abort
  let cmd = alda#ShellInput(a:input) . alda#Command("play")
  call alda#RunAsync(cmd, function('alda#StandardCallback'))
endfunction

function! alda#playing#Play(input) abort
  if alda#repl#Connected()
    return alda#repl#Play(a:input)
  else
    call alda#playing#PlayDisconnected(a:input)
  endif
endfunction

function! alda#playing#PlayOperator(type)
  call alda#Operator(a:type, function('alda#playing#Play'))
endfunction

function! alda#playing#PlayDisconnectedOperator(type)
  call alda#Operator(a:type, function('alda#playing#PlayDisconnected'))
endfunction

function! alda#playing#StopPlayback() abort
  if alda#repl#Connected()
    return alda#repl#Stop()
  else
    call alda#RunAsync(alda#Command("stop"))
  endif
endfunction
