require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = '> ',
  },
  popup = {
    position = {
      row = '2%',
      col = '50%',
    },
    size = {
      width = '50%',
    },
    border = {
      style = 'rounded',
    },
    buf_options = {
      filetype = 'FineCmdlinePrompt'
    }
  },
  before_mount = function(input)
    vim.api.nvim_buf_set_option(input.bufnr, 'filetype', 'fine_cmdline')
  end,
})

vim.opt.cmdheight = 0
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
