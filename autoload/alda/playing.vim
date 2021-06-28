function! alda#playing#Play(input)
  let cmd = alda#ShellInput(a:input) . alda#Command("play")
  call alda#RunAsync(cmd, function('alda#StandardCallback'), a:input)
endfunction

function! alda#playing#PlayOperator(type)
  call alda#Operator(a:type, function('alda#playing#Play'))
endfunction

function! alda#playing#StopPlayback()
  call alda#RunAsync(alda#Command("stop"))
endfunction
