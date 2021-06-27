command! AldaParseBuffer
  \ call alda#parsing#ParseBuffer()

nnoremap <silent> <buffer> <localleader>s
  \ :call alda#parsing#ParseBuffer()<CR>

command! AldaParseBufferEvents
  \ call alda#parsing#ParseBufferEvents()

nnoremap <silent> <buffer> <localleader>E
  \ :call alda#parsing#ParseBufferEvents()<CR>

