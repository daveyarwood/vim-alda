function! alda#parsing#OpenClosableJsonSplitBuffer(cmd)
  vsplit __alda_buffer__
  setlocal buftype=nofile
  " enable 'q' = close buffer
  nnoremap <buffer> q :bd<CR>

  normal! ggdG
  call append(0, ["Parsing score. Please wait..."])
  redraw

  let result = system(a:cmd)

  if v:shell_error == 0
    setlocal filetype=json
  endif

  normal! ggdG
  call append(0, split(result, '\v\n'))
endfunction

function! alda#parsing#AldaParseFile()
  let cmd = g:alda_command . " parse --file " . shellescape(bufname("%"))
  " If jq is available on $PATH, use it to pretty-print the JSON.
  if executable('jq')
    let cmd = l:cmd . " | jq '.'"
  endif
  call alda#parsing#OpenClosableJsonSplitBuffer(cmd)
endfunction

