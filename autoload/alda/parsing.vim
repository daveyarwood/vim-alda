function! alda#parsing#OpenClosableClojureSplitBuffer(cmd)
  vsplit __alda_buffer__
  setlocal buftype=nofile
  " enable 'q' = close buffer
  nnoremap <buffer> q :bd<CR>

  normal! ggdG
  call append(0, ["Parsing score. Please wait..."])
  redraw

  let result = system(a:cmd)

  if v:shell_error == 0
    setlocal filetype=clojure
  endif

  normal! ggdG
  call append(0, split(result, '\v\n'))
endfunction

function! alda#parsing#AldaParseFileIntoLispCode()
  let cmd = g:alda_command . " parse --lisp --file " . bufname("%")
  call alda#parsing#OpenClosableClojureSplitBuffer(cmd)
endfunction

function! alda#parsing#AldaParseFileIntoScoreMap()
  let cmd = g:alda_command . " parse --map --file " . bufname("%")
  call alda#parsing#OpenClosableClojureSplitBuffer(cmd)
endfunction

