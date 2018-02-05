""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" history file

" A buffer-local file containing Alda code evaluated/played thus far. Each time
" code is successfully evaluated, it is appended to the file. When playing
" subsequent snippets of code, this history is provided for context, so that
" Alda knows e.g.  what instruments are active when playing small pieces of
" code.
if !exists("b:alda_history_file")
  let b:alda_history_file = tempname()
  " write to the file so it exists and is empty
  call alda#playing#ClearHistory()
endif

command! AldaHistoryFile echo b:alda_history_file
command! AldaHistory echon join(readfile(fnameescape(b:alda_history_file)), "\n")
command! AldaEditHistory exec "e " . fnameescape(b:alda_history_file)
command! AldaClearHistory call alda#playing#ClearHistory()

nnoremap <buffer> <localleader>hh :AldaHistory<CR>
nnoremap <buffer> <localleader>he :AldaEditHistory<CR>
nnoremap <buffer> <localleader>hc :AldaClearHistory<CR>

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
  execute "normal! ggvG$:\<c-u>call alda#playing#PlayOperator(visualmode())\<cr>"
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

