return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('treesitter-context').setup({
        min_window_height = 30,
        max_lines = 3,
        separator = '―',
      })
      require('plugins.treesitter.textobjects').setup()
    end,
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {
        'gS',
        function()
          require('treesj').split()
        end,
        desc = 'ts: split block',
      },
      {
        'gJ',
        function()
          require('treesj').join()
        end,
        desc = 'ts: join block',
      },
    },
    opts = {
      check_syntax_error = false,
    },
  },
}
