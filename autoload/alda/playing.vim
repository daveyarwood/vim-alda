function! alda#playing#AldaPlayFile()
  let cmd = g:alda_command . " play --file " . shellescape(bufname("%"))
  echom "Playing score..."
  let result = system(cmd)
  if v:shell_error == 1
    echom result
  else
    echom "Done."
  endif
endfunction

