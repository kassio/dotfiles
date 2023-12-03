local opt = vim.opt_local

opt.bufhidden = 'hide'
opt.cursorline = false
opt.number = false
opt.relativenumber = false
opt.scrolloff = 0
opt.spell = false
opt.signcolumn = 'no'
opt.foldcolumn = '0'
opt.colorcolumn = {}

local function buf_keymap(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { buffer = 0, silent = true })
end

buf_keymap('n', '<c-t>', ':exec "tab cc".line(".")<cr>')
buf_keymap('n', '<c-x>', ':exec "cc".line(".")<cr>')
buf_keymap('n', '<c-v>', ':exec "vert cc ".line(".")<cr>')
