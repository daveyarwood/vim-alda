if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

command! AldaPlayFile
  \ call alda#playing#AldaPlayFile()

nnoremap <buffer> <localleader>P
  \ :call alda#playing#AldaPlayFile()<CR>

