au BufNewFile,BufRead *.alda setfiletype alda

" tpope/vim-commentary lets you comment out lines using the `gc` operator
" this line tells vim-commentary to use # to comment out lines in Alda
au BufNewFile,BufRead *.alda setlocal commentstring=#\ %s

