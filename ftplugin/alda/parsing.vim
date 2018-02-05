command! AldaParseBuffer
  \ call alda#parsing#ParseBuffer()

nnoremap <buffer> <localleader>s
  \ :call alda#parsing#ParseBuffer()<CR>

command! AldaParseBufferEvents
  \ call alda#parsing#ParseBufferEvents()

nnoremap <buffer> <localleader>E
  \ :call alda#parsing#ParseBufferEvents()<CR>

