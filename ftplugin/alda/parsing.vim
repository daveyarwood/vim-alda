command! AldaParseFile
  \ call alda#parsing#ParseFile()

nnoremap <buffer> <localleader>s
  \ :call alda#parsing#ParseFile()<CR>

