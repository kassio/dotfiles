local g = vim.g
local fn = vim.fn

g.fzf_command_prefix = 'Fuzzy'
g.fzf_history_dir = '~/.fzf-history'
g.fzf_buffers_jump = 1
g.fzf_layout = {
  window = {
    width = 0.95,
    height = 0.7,
    relative = false,
    yoffset = 0,
    border = 'rounded',
  },
}
g.fzf_preview_window = { 'right:60%:+{2}-/2', 'ctrl-/' }
g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

vim.my.fuzzyfinder = {
  grep = function()
    vim.cmd('normal !')
    vim.cmd('FuzzyRg ' .. fn.getreg('"v'))
  end,
}
