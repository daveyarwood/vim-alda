command! AldaParseBuffer
  \ call alda#parsing#ParseBuffer()

nnoremap <buffer> <localleader>s
  \ :call alda#parsing#ParseBuffer()<CR>

