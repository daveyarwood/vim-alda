function! alda#NextNonBlankLine(lnum)
  let numlines = line('$')
  let current  = a:lnum + 1

  while current <= numlines
    if getline(current) =~? '\v\S'
      return current
    endif

    let current += 1
  endwhile

  return -2
endfunction

function! alda#IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! alda#GetFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  let this_indent = alda#IndentLevel(a:lnum)
  let next_indent = alda#IndentLevel(alda#NextNonBlankLine(a:lnum))

  if next_indent > this_indent
    return '>' . next_indent
  else
    return this_indent
  endif

  return '0'
endfunction
