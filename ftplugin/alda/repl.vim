command! -nargs=? AldaConnect
      \ call alda#repl#Connect(<f-args>)

nnoremap <silent> <buffer> <localleader>c
      \ :AldaConnect<CR>

nnoremap <buffer> <localleader>C
      \ :AldaConnect<space>

command! AldaDisconnect
      \ call alda#repl#Disconnect()

nnoremap <silent> <buffer> <localleader>d
      \ :call alda#repl#Disconnect()<CR>

command! AldaNewScore
      \ call alda#repl#NewScore()

nnoremap <silent> <buffer> <localleader>n
      \ :call alda#repl#NewScore()<CR>

command! AldaScoreText
      \ call alda#repl#ScoreText()

nnoremap <silent> <buffer> <localleader>t
      \ :call alda#repl#ScoreText()<CR>
