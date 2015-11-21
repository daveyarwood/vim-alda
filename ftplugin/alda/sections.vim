function! s:NextSection(type, backwards, visual)
  if a:visual
    normal! gv
  endif

  if a:type == 1
    let pattern = '\v(\n\n^\S|%^)'
    let flags = 'e'
  elseif a:type == 2
    let pattern = '\v^\S.*:\s*$'
    let flags = ''
  endif

  if a:backwards
    let dir = '?'
  else
    let dir = '/'
  endif

  execute 'silent! normal! ' . dir . pattern . dir . flags . "\r"
endfunction

noremap <script> <buffer> <silent> ]]
        \ :call <SID>NextSection(1, 0, 0)<cr>
noremap <script> <buffer> <silent> [[
        \ :call <SID>NextSection(1, 1, 0)<cr>
noremap <script> <buffer> <silent> ][
        \ :call <SID>NextSection(2, 0, 0)<cr>
noremap <script> <buffer> <silent> []
        \ :call <SID>NextSection(2, 1, 0)<cr>

vnoremap <script> <buffer> <silent> ]]
        \ :<c-u>call <SID>NextSection(1, 0, 1)<cr>

vnoremap <script> <buffer> <silent> [[
        \ :<c-u>call <SID>NextSection(1, 1, 1)<cr>

vnoremap <script> <buffer> <silent> ][
        \ :<c-u>call <SID>NextSection(2, 0, 1)<cr>

vnoremap <script> <buffer> <silent> []
        \ :<c-u>call <SID>NextSection(2, 1, 1)<cr>
