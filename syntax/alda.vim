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

syntax match aldaVoice "\vV[[:digit:]]+:"
highlight link aldaVoice Type

syntax match aldaMarker "\v\%[a-zA-Z]{2,}[\w[:digit:]\-+'()]*"
highlight link aldaMarker Special

syntax match aldaAtMarker "\v\@[a-zA-Z]{2,}[\w[:digit:]\-+'()]*"
highlight link aldaAtMarker Special

syntax match aldaOctaveChange "\vo\-?\d+|\<|\>"
highlight link aldaOctaveChange PreProc

syntax match aldaComment "\v#.*$"
syntax match aldaComment "\v\|"
highlight link aldaComment Comment

let b:current_syntax = "alda"
