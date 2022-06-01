vim.my.winbar = function()
  return table.concat({
    '%n',
    ' | ',
    '%f',
    '%m%r%h',
    '%<',
    '%=',
    '%3l:%-3c',
    ' | ',
    '%p%%',
  }, '')
end

vim.opt.winbar = '%!v:lua.vim.my.winbar()'
