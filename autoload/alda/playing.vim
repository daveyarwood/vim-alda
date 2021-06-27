function s:PlayCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let output = join(a:data, '')
    if strlen(output) > 0
      echom output
    endif
  elseif a:event == 'stderr'
    let output = join(a:data, '')
    if strlen(output) > 0
      echom output
    endif
  endif
endfunction

function s:StopCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let output = join(a:data, '')
    if strlen(output) > 0
      echom output
    endif
  elseif a:event == 'stderr'
    let output = join(a:data, '')
    if strlen(output) > 0
      echom output
    endif
  endif
endfunction

function! alda#playing#Play(input)
  let cmd = alda#ShellInput(a:input) . alda#Command("play")
  call alda#RunAsync(cmd, function('s:PlayCallback'), a:input)
endfunction

function! alda#playing#PlayOperator(type)
  call alda#Operator(a:type, function('alda#playing#Play'))
endfunction

function! alda#playing#StopPlayback()
  call alda#RunAsync(alda#Command("stop"), function('s:StopCallback'))
endfunction
