if exists("b:current_syntax")
  finish
endif

syntax match aldaComment "\v#.*$"
syntax match aldaComment "\v\|"
highlight link aldaComment Comment

syntax match aldaPart "\v[a-zA-Z]{2,}[\w[:digit:]\-+'()]*"
highlight link aldaPart Function

syntax match aldaOctaveChange "\vo\-?\d+|\<|\>"
highlight link aldaOctaveChange Identifier

let b:current_syntax = "alda"
