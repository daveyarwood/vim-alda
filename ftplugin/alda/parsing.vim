if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

function! s:OpenClosableClojureSplitBuffer(txt)
  vsplit __alda_buffer__
  normal! ggdG

  setlocal filetype=clojure
  setlocal buftype=nofile

  " enable 'q' = close buffer
  nnoremap <buffer> q :bd<CR>

  call append(0, split(a:txt, '\v\n'))
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! AldaParseFileIntoLispCode()
  let alda_lisp_code = system(g:alda_command . " parse --lisp --file " . bufname("%"))
  call <SID>OpenClosableClojureSplitBuffer(alda_lisp_code)
endfunction

command! AldaParseFileIntoLispCode call AldaParseFileIntoLispCode()
nnoremap <buffer> <localleader>l :call AldaParseFileIntoLispCode()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! AldaParseFileIntoScoreMap()
  let alda_score_map = system(g:alda_command . " parse --map --file " . bufname("%"))
  call <SID>OpenClosableClojureSplitBuffer(alda_score_map)
endfunction

command! AldaParseFileIntoScoreMap call AldaParseFileIntoScoreMap()
nnoremap <buffer> <localleader>m :call AldaParseFileIntoScoreMap()<CR>

