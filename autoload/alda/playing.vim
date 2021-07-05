function! alda#playing#Play(input) abort
  if alda#repl#Connected()
    return alda#repl#Play(a:input)
  else
    let cmd = alda#ShellInput(a:input) . alda#Command("play")
    call alda#RunAsync(cmd, function('alda#StandardCallback'))
  endif
endfunction

function! alda#playing#PlayOperator(type)
  call alda#Operator(a:type, function('alda#playing#Play'))
endfunction

function! alda#playing#StopPlayback() abort
  if alda#repl#Connected()
    return alda#repl#Stop()
  else
    call alda#RunAsync(alda#Command("stop"))
  endif
endfunction
