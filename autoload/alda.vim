if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

function! alda#NextNonBlankLine(lnum)
  let numlines = line('$')
  let current  = a:lnum + 1

  while current <= numlines
    if getline(current) =~? '\v\S'
      return current
    endif

    let current += 1
  endwhile

  return -2
endfunction

function! alda#IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! alda#GetFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  let this_indent = alda#IndentLevel(a:lnum)
  let next_indent = alda#IndentLevel(alda#NextNonBlankLine(a:lnum))

  if next_indent > this_indent
    return '>' . next_indent
  else
    return this_indent
  endif

  return '0'
endfunction

function s:NoOp(job_id, data, event)
  " do nothing
endfunction

" Runs `cmd` in the shell as an asynchronous job.
"
" Calls `Callback` upon receiving STDOUT, STDERR, or the process exiting.
" (See :help job-control-usage).
"
" A string of `alda_code` can be provided in order to pass it through to the
" callback function (as `self.alda_code`).
function! alda#RunAsync(cmd, ...)
  let Callback = (a:0 >= 1) ? a:1 : function('s:NoOp')
  let alda_code = (a:0 >= 2) ? a:2 : ""

  call jobstart(a:cmd, {
        \ 'on_stdout': Callback,
        \ 'on_stderr': Callback,
        \ 'on_exit': Callback,
        \ 'alda_code': alda_code,
        \ 'output': []
        \ })
endfunction

function! alda#ShellInput(input)
  let input = substitute(a:input, '\n', '\\n', 'g')
  return "echo -e " . shellescape(input) . " | "
endfunction

