return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'tpope/vim-fugitive',
  },
  config = function()
    local gitsigns = require('gitsigns')

    gitsigns.setup({
      signs = {
        add = { text = '▎' },
        untracked = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '▎' },
        topdelete = { text = '‾' },
        changedelete = { text = '_' },
      },
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author> - <summary>, <author_time:%Y%m%d>',
      diff_opts = { vertical = true },
      numhl = true,
    })

    require('plugins.git.commands').setup()
    require('plugins.git.keymaps').setup(gitsigns)
  end,
}
