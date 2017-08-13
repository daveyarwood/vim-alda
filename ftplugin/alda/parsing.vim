if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! AldaParseFile
  \ call alda#parsing#ParseFile()

nnoremap <buffer> <localleader>s
  \ :call alda#parsing#ParseFile()<CR>

