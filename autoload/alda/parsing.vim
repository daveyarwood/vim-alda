function s:PrintResults(lines, ...)
  let is_json = (a:0 >= 1) ? a:1 : 0

  echom "Displaying parse results..."
  let tempfile = tempname()
  call writefile(a:lines, fnameescape(tempfile))

  exec 'vsplit ' . fnameescape(tempfile)
  setlocal buftype=nofile
  " enable 'q' = close buffer
  nnoremap <buffer> q :bd<CR>

  if is_json
    setlocal filetype=json
  endif
endfunction

function s:PrettyPrintResults(job_id, data, event) dict
  if a:event == 'stdout'
    let self.output += a:data
  elseif a:event == 'stderr'
    let self.output += a:data
  elseif a:event == 'exit'
    call s:PrintResults(self.output, 1)
  endif
endfunction

function s:ParseCallback(job_id, data, event) dict
  if a:event == 'stdout'
    let self.output += a:data
  elseif a:event == 'stderr'
    let self.output += a:data
  elseif a:event == 'exit'
    " If exit code is 0 and jq is available on $PATH, use it to pretty-print the
    " JSON.
    if a:data ==# 0 && executable('jq')
      echom "Pretty-printing parse results..."
      let json = join(self.output, '')
      let cmd = alda#ShellInput(json) . "jq '.'"
      call alda#RunAsync(cmd, function('s:PrettyPrintResults'))
    else
      call s:PrintResults(self.output)
    endif
  endif
endfunction

function! alda#parsing#ParseBuffer()
  let code = join(getline(1,'$'), "\n")
  let cmd = alda#ShellInput(code) . alda#ServerCommand("parse")
  echom "Parsing score..."
  call alda#RunAsync(cmd, function('s:ParseCallback'))
endfunction

