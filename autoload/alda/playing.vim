function s:PlayCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let output = join(a:data, '')
    echom output
  elseif a:event == 'stderr'
    let output = join(a:data, '')
    if strlen(output) > 0
      echoe output
    endif
  elseif a:event == 'exit'
    " If playback was successful, append the code to b:alda_history.
    if a:data ==# 0 " exit code
      let lines = split(self.alda_code, '\n')
      call writefile(lines, fnameescape(b:alda_history_file), "a")
    endif
  endif
endfunction

function s:StopCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let output = join(a:data, '')
    echom output
  elseif a:event == 'stderr'
    let output = join(a:data, '')
    if strlen(output) > 0
      echoe output
    endif
  elseif a:event == 'exit'
    " assume it succeeded
  endif
endfunction

function alda#playing#ClearHistory()
  call writefile([""], fnameescape(b:alda_history_file))
endfunction

function! alda#playing#Play(input)
  let cmd = alda#ShellInput(a:input) .
        \ alda#ServerCommand("play -I " . fnameescape(b:alda_history_file))
  call alda#RunAsync(cmd, function('s:PlayCallback'), a:input)
endfunction

function! alda#playing#PlayOperator(type)
  call alda#Operator(a:type, function('alda#playing#Play'))
endfunction

function! alda#playing#StopPlayback()
  call alda#RunAsync(alda#ServerCommand("stop"), function('s:StopCallback'))
endfunction
