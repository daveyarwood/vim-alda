au BufNewFile,BufRead *.alda setfiletype alda

" tpope/vim-commentary lets you comment out lines using the `gc` operator
" this line tells vim-commentary to use # to comment out lines in Alda
au BufNewFile,BufRead *.alda setlocal commentstring=#\ %s

" luochen1990/rainbow (a rainbow parentheses plugin) messes up the highlighting
" of syntax regions. We have to disable it for Alda buffers to get proper syntax
" highlighting.
au BufNewFile,BufRead *.alda
      \ if exists(':RainbowToggleOff')
      \ | execute ":RainbowToggleOff"
      \ | endif
