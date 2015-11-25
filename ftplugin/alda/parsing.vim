if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! AldaParseFileIntoLispCode
  \ call alda#parsing#AldaParseFileIntoLispCode()

nnoremap <buffer> <localleader>l
  \ :call alda#parsing#AldaParseFileIntoLispCode()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! AldaParseFileIntoScoreMap
  \ call alda#parsing#AldaParseFileIntoScoreMap()

nnoremap <buffer> <localleader>m
  \ :call alda#parsing#AldaParseFileIntoScoreMap()<CR>

