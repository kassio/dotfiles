return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',

      'theHamsta/nvim-treesitter-pairs',

      -- Better pairs matching
      'andymass/vim-matchup',
    },
    config = function()
      -- vim-matchup plugin, uses treesitter
      -- Do not show the not visible matching context on statusline
      vim.g.matchup_matchparen_offscreen = {}

      require('treesitter-context').setup({
        min_window_height = 30,
        max_lines = 3,
        separator = '―',
      })
      require('plugins.treesitter.config').setup()
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
