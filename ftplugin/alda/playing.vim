if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

function! AldaPlayFile()
  let cmd = g:alda_command . " play --file " . bufname("%")
  echom "Playing score..."
  let result = system(cmd)
  if v:shell_error == 1
    echom result
  else
    echom "Done."
  endif
endfunction

command! AldaPlayFile call AldaPlayFile()
nnoremap <buffer> <localleader>P :call AldaPlayFile()<CR>
