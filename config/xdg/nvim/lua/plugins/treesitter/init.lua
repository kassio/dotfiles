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

      require('treesitter-context').setup()
      require('plugins.treesitter.config').setup()
    end,
  },

  {
    'ThePrimeagen/refactoring.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      local refactoring = require('refactoring')

      local refactoring_cmd = function(name)
        local cmd_name = 'Refactoring' .. string.gsub(name, '%s', '')

        vim.api.nvim_create_user_command(cmd_name, function()
          refactoring.refactor(name)
        end, { range = true })
      end

      refactoring_cmd('Extract Function')
      refactoring_cmd('Extract Function To File')
      refactoring_cmd('Extract Variable')
      refactoring_cmd('Inline Variable')
      refactoring_cmd('Extract Block')
      refactoring_cmd('Extract Block To File')
      refactoring_cmd('Inline Variable')
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
    config = function()
      require('treesj').setup({
        check_syntax_error = false,
      })
    end,
  },
}
