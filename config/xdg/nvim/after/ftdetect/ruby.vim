aug user:ruby
  au!
  au BufNewFile,BufRead .simplecov,Dangerfile,pryrc,irbrc call s:rubyfile()
aug END

function! s:rubyfile()
  set filetype=ruby
endfunction
