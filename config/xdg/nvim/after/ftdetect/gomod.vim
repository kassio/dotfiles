aug user:gomod
  au!
  au BufNewFile,BufRead go.mod call s:gomodfile()
aug END

function! s:gomodfile()
  set filetype=gomod
endfunction
