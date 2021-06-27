""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" play operator

nnoremap <buffer> <localleader>p :set operatorfunc=alda#playing#PlayOperator<cr>g@
nmap <buffer> <localleader>pp V<localleader>p
vnoremap <buffer> <localleader>p :<c-u>call alda#playing#PlayOperator(visualmode())<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" parse events operator

nnoremap <buffer> <localleader>e :set operatorfunc=alda#parsing#ParseEventsOperator<cr>g@
nmap <buffer> <localleader>ee V<localleader>e
vnoremap <buffer> <localleader>e :<c-u>call alda#parsing#ParseEventsOperator(visualmode())<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" play contents of buffer

function! alda#playing#PlayBuffer()
  let pos = winsaveview()
  execute "normal! gg0vG$:\<c-u>call alda#playing#PlayOperator(visualmode())\<cr>"
  call winrestview(pos)
endfunction

command! AldaPlayBuffer
  \ call alda#playing#PlayBuffer()

nnoremap <buffer> <localleader>P
  \ :call alda#playing#PlayBuffer()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" stop playback

command! AldaStopPlayback
  \ call alda#playing#StopPlayback()

nnoremap <buffer> <localleader>S
  \ :call alda#playing#StopPlayback()<CR>

