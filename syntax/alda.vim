if exists("b:current_syntax")
  finish
endif

syntax include @Clojure syntax/clojure.vim
syntax region aldaClojureExpr
      \ matchgroup=clojureParen
      \ start=+(+
      \ end=+)+
      \ contains=@Clojure

syntax match aldaIdentifier "\v[a-zA-Z]{2,}[\w[:digit:]\-+'()]*"
highlight link aldaIdentifier Function

syntax match aldaOctaveChange "\vo\-?\d+|\<|\>"
highlight link aldaOctaveChange Identifier

syntax match aldaComment "\v#.*$"
syntax match aldaComment "\v\|"
highlight link aldaComment Comment

let b:current_syntax = "alda"
