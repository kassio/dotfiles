aug user:rspec
  au!
  au BufNewFile,BufRead spec/**/*_spec.rb call s:set_filetype()
aug END

function! s:set_filetype()
  setl syntax=rspec
endfunction

