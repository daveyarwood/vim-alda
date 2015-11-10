if exists("b:current_syntax")
  finish
endif

syntax match aldaPart "\v[a-zA-Z]{2,}[\w[:digit:]\-+'()]*"
highlight link aldaPart Function

syntax match aldaOctaveChange "\vo\-?\d+|\<|\>"
highlight link aldaOctaveChange Identifier

syntax match aldaComment "\v#.*$"
syntax match aldaComment "\v\|"
highlight link aldaComment Comment

syntax region aldaClojureExpr start=/\v\(/ skip=/\v\\.|".*"/ end=/\v\)/
highlight link aldaClojureExpr String

let b:current_syntax = "alda"
