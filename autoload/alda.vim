if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

function! alda#Command(the_rest)
  return g:alda_command . " " . a:the_rest
endfunction

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

" A standard callback that prints lines of stdout/stderr using echo.
function alda#StandardCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let output = trim(join(a:data, "\n"))
    if strlen(output) > 0
      echo output
    endif
  elseif a:event == 'stderr'
    let output = trim(join(a:data, "\n"))
    if strlen(output) > 0
      echo output
    endif
  endif
endfunction

" Runs `cmd` in the shell as an asynchronous job. Returns the job ID.
"
" Calls `Callback` upon receiving STDOUT, STDERR, or the process exiting.
" (See :help job-control-usage). When no `Callback` argument is supplied,
" defaults to a standard callback where we print lines of stdout and stderr
" using echo.
function! alda#RunAsync(cmd, ...)
  let Callback = (a:0 >= 1) ? a:1 : function('alda#StandardCallback')

  return jobstart(a:cmd, {
        \ 'env': {'NO_COLOR': 'true'},
        \ 'on_stdout': Callback,
        \ 'on_stderr': Callback,
        \ 'on_exit': Callback,
        \ 'output': []
        \ })
endfunction

function! alda#ShellInput(input)
  let input = substitute(a:input, '\n', '\\n', 'g')
  return "echo -e " . shellescape(input) . " | "
endfunction

" Convenience function for creating vim operators.
function! alda#Operator(type, callback)
  let previous = @n

  " yank target/selected text into "n
  if a:type ==# 'char' || a:type ==# 'line'
    silent! normal `[v`]"ny
  else "visual
    silent! normal gv"ny
  endif

  let input = @n

  " restore whatever was in "n before
  let @n = previous

  call a:callback(input)
endfunction

